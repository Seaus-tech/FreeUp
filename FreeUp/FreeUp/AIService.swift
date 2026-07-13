import Foundation
import Combine

// MARK: - AI Provider

enum AIProvider: String, CaseIterable {
    case openAI = "OpenAI"
    case ollama = "Ollama"
}

// MARK: - Message

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: String   // "user" | "assistant" | "tool"
    let content: String
    var toolCallId: String? = nil
    var isLoading: Bool = false
}

// MARK: - Tool Call Result

enum AIToolAction {
    case cleanCategory(String)
    case cleanAll
    case runScan
    case showSection(String)
}

// MARK: - AI Service

@MainActor
class AIService: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isThinking = false
    @Published var provider: AIProvider = .openAI
    @Published var openAIKey: String = UserDefaults.standard.string(forKey: "openAIKey") ?? ""
    @Published var ollamaModel: String = UserDefaults.standard.string(forKey: "ollamaModel") ?? "llama3"
    @Published var ollamaURL: String = UserDefaults.standard.string(forKey: "ollamaURL") ?? "http://localhost:11434"

    var onAction: ((AIToolAction) -> Void)?

    private let systemPrompt = """
    You are FreeUp AI, a helpful Mac disk cleaning assistant built into the FreeUp app.
    You help users understand what's taking up space, what's safe to delete, and why their Mac might be slow.
    You have access to tools to run scans and clean files directly.
    Be concise and friendly. When suggesting a clean, use the available tools to do it.
    """

    private var tools: [[String: Any]] {
        [
            [
                "type": "function",
                "function": [
                    "name": "run_scan",
                    "description": "Run a full disk scan to find junk files, caches, logs, and large files.",
                    "parameters": ["type": "object", "properties": [:], "required": []]
                ]
            ],
            [
                "type": "function",
                "function": [
                    "name": "clean_category",
                    "description": "Clean files of a specific category found in the last scan.",
                    "parameters": [
                        "type": "object",
                        "properties": [
                            "category": [
                                "type": "string",
                                "enum": ["User Cache", "System Cache", "App Support Cache", "Container Cache",
                                         "Log Files", "Temp Files", "Xcode Junk", "Dev Tool Cache",
                                         "Trash", "Large Files", "Downloads", "App Leftovers", "Privacy Traces"]
                            ]
                        ],
                        "required": ["category"]
                    ]
                ]
            ],
            [
                "type": "function",
                "function": [
                    "name": "clean_all",
                    "description": "Clean all junk files found in the last scan.",
                    "parameters": ["type": "object", "properties": [:], "required": []]
                ]
            ],
            [
                "type": "function",
                "function": [
                    "name": "show_section",
                    "description": "Navigate to a specific section of FreeUp.",
                    "parameters": [
                        "type": "object",
                        "properties": [
                            "section": [
                                "type": "string",
                                "enum": ["Smart Care", "Cleanup", "Protection", "Performance",
                                         "Applications", "My Clutter", "Space Lens", "Cloud Cleanup",
                                         "My Tools", "My Activity"]
                            ]
                        ],
                        "required": ["section"]
                    ]
                ]
            ]
        ]
    }

    func saveSettings() {
        UserDefaults.standard.set(openAIKey, forKey: "openAIKey")
        UserDefaults.standard.set(ollamaModel, forKey: "ollamaModel")
        UserDefaults.standard.set(ollamaURL, forKey: "ollamaURL")
    }

    func send(userMessage: String, context: String = "") async {
        let fullMessage = context.isEmpty ? userMessage : "\(userMessage)\n\n[Context: \(context)]"
        messages.append(ChatMessage(role: "user", content: userMessage))
        isThinking = true

        do {
            switch provider {
            case .openAI: try await sendOpenAI(userText: fullMessage)
            case .ollama:  try await sendOllama(userText: fullMessage)
            }
        } catch {
            messages.append(ChatMessage(role: "assistant", content: "Error: \(error.localizedDescription)"))
        }
        isThinking = false
    }

    // MARK: - OpenAI

    private func sendOpenAI(userText: String) async throws {
        guard !openAIKey.isEmpty else {
            messages.append(ChatMessage(role: "assistant", content: "Please add your OpenAI API key in AI settings."))
            return
        }

        var history: [[String: Any]] = [["role": "system", "content": systemPrompt]]
        for m in messages {
            if m.role == "tool" {
                history.append(["role": "tool", "tool_call_id": m.toolCallId ?? "", "content": m.content])
            } else {
                history.append(["role": m.role, "content": m.content])
            }
        }

        let body: [String: Any] = [
            "model": "gpt-4o",
            "messages": history,
            "tools": tools,
            "tool_choice": "auto"
        ]

        var req = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        req.httpMethod = "POST"
        req.setValue("Bearer \(openAIKey)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: req)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        let choice = (json?["choices"] as? [[String: Any]])?.first
        let msg = choice?["message"] as? [String: Any]

        // Handle tool calls
        if let toolCalls = msg?["tool_calls"] as? [[String: Any]] {
            for call in toolCalls {
                let callId = call["id"] as? String ?? ""
                let fn = call["function"] as? [String: Any]
                let name = fn?["name"] as? String ?? ""
                let argsStr = fn?["arguments"] as? String ?? "{}"
                let args = (try? JSONSerialization.jsonObject(with: Data(argsStr.utf8))) as? [String: Any] ?? [:]

                let result = handleToolCall(name: name, args: args)
                messages.append(ChatMessage(role: "tool", content: result, toolCallId: callId))
            }
            // Follow-up after tool execution
            try await sendOpenAI(userText: "")
        } else if let text = msg?["content"] as? String {
            messages.append(ChatMessage(role: "assistant", content: text))
        }
    }

    // MARK: - Ollama

    private func sendOllama(userText: String) async throws {
        let base = ollamaURL.hasSuffix("/") ? String(ollamaURL.dropLast()) : ollamaURL
        guard let url = URL(string: "\(base)/api/chat") else {
            messages.append(ChatMessage(role: "assistant", content: "Invalid Ollama URL. Check AI settings."))
            return
        }

        var history: [[String: Any]] = [["role": "system", "content": systemPrompt]]
        for m in messages where m.role != "tool" {
            history.append(["role": m.role, "content": m.content])
        }

        // Note: tool calling omitted — most local models don't support it reliably.
        // Instead, parse intent from the response text.
        let body: [String: Any] = [
            "model": ollamaModel,
            "messages": history,
            "stream": false
        ]

        var req = URLRequest(url: url, timeoutInterval: 60)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: req)

        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            messages.append(ChatMessage(role: "assistant", content: "Ollama returned error \(code). Is `ollama serve` running?"))
            return
        }

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let text = (json?["message"] as? [String: Any])?["content"] as? String else {
            messages.append(ChatMessage(role: "assistant", content: "Unexpected response from Ollama."))
            return
        }

        messages.append(ChatMessage(role: "assistant", content: text))

        // Parse intent from response to trigger actions
        let lower = text.lowercased()
        if lower.contains("scan") && lower.contains("run") || lower.contains("start scan") {
            onAction?(.runScan)
        } else if lower.contains("clean all") || lower.contains("delete all") {
            onAction?(.cleanAll)
        }
    }

    // MARK: - Tool Dispatch

    private func handleToolCall(name: String, args: [String: Any]) -> String {
        switch name {
        case "run_scan":
            onAction?(.runScan)
            return "Scan started."
        case "clean_all":
            onAction?(.cleanAll)
            return "Cleaning all junk files."
        case "clean_category":
            let cat = args["category"] as? String ?? ""
            onAction?(.cleanCategory(cat))
            return "Cleaning \(cat)."
        case "show_section":
            let section = args["section"] as? String ?? ""
            onAction?(.showSection(section))
            return "Navigated to \(section)."
        default:
            return "Unknown tool."
        }
    }
}
