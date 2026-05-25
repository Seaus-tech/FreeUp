import SwiftUI
import Combine

struct AIAssistantView: View {
    @ObservedObject var engine: CleanerEngine
    @StateObject private var ai = AIService()
    @State private var input = ""
    @State private var showSettings = false
    @FocusState private var inputFocused: Bool

    // Quick prompts
    private let quickPrompts = [
        "What's safe to delete?",
        "Why is my Mac slow?",
        "Scan and clean everything",
        "Show me what's using the most space",
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("FreeUp AI").font(.system(size: 24, weight: .bold)).foregroundStyle(.white)
                    Text("Powered by \(ai.provider.rawValue)")
                        .font(.system(size: 12)).foregroundStyle(.white.opacity(0.5))
                }
                Spacer()
                // Provider toggle
                Picker("", selection: $ai.provider) {
                    ForEach(AIProvider.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .frame(width: 160)

                Button { showSettings.toggle() } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.white.opacity(0.6))
                }
                .buttonStyle(.plain)
                .popover(isPresented: $showSettings) { settingsPopover }
            }
            .padding(.horizontal, 24).padding(.top, 24).padding(.bottom, 16)

            Divider().background(Color.white.opacity(0.1))

            // Messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        if ai.messages.isEmpty {
                            emptyState
                        }
                        ForEach(ai.messages.filter { $0.role != "tool" }) { msg in
                            MessageBubble(message: msg)
                                .id(msg.id)
                        }
                        if ai.isThinking {
                            ThinkingBubble()
                        }
                    }
                    .padding(16)
                }
                .onChange(of: ai.messages.count) { _, _ in
                    if let last = ai.messages.last { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }

            // Quick prompts (only when empty)
            if ai.messages.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(quickPrompts, id: \.self) { prompt in
                            Button(prompt) { sendWithContext(prompt) }
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white.opacity(0.8))
                                .padding(.horizontal, 12).padding(.vertical, 7)
                                .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
                                .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 8)
            }

            Divider().background(Color.white.opacity(0.1))

            // Input bar
            HStack(spacing: 10) {
                TextField("Ask anything about your Mac…", text: $input)
                    .textFieldStyle(.plain)
                    .foregroundStyle(.white)
                    .focused($inputFocused)
                    .onSubmit { sendMessage() }

                Button { sendMessage() } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(input.isEmpty ? Color.white.opacity(0.2) : Color(hex:"7b5cf0"))
                }
                .buttonStyle(.plain)
                .disabled(input.isEmpty || ai.isThinking)
            }
            .padding(.horizontal, 16).padding(.vertical, 12)
        }
        .onAppear {
            ai.onAction = { action in handleAction(action) }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 48)).foregroundStyle(Color(hex:"7b5cf0").opacity(0.6))
            Text("FreeUp AI").font(.system(size: 20, weight: .semibold)).foregroundStyle(.white)
            Text("Ask me anything about your Mac's storage,\nperformance, or what to clean.")
                .font(.system(size: 14)).foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }

    // MARK: - Settings Popover

    private var settingsPopover: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("AI Settings").font(.headline)

            if ai.provider == .openAI {
                VStack(alignment: .leading, spacing: 6) {
                    Text("OpenAI API Key").font(.caption).foregroundStyle(.secondary)
                    SecureField("sk-...", text: $ai.openAIKey)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 260)
                }
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Ollama URL").font(.caption).foregroundStyle(.secondary)
                    TextField("http://localhost:11434", text: $ai.ollamaURL)
                        .textFieldStyle(.roundedBorder).frame(width: 260)
                    Text("Model").font(.caption).foregroundStyle(.secondary)
                    TextField("llama3", text: $ai.ollamaModel)
                        .textFieldStyle(.roundedBorder).frame(width: 260)
                }
            }

            Button("Save") { ai.saveSettings(); showSettings = false }
                .buttonStyle(.borderedProminent)
        }
        .padding(20)
    }

    // MARK: - Actions

    private func sendMessage() {
        guard !input.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        sendWithContext(input)
        input = ""
    }

    private func sendWithContext(_ text: String) {
        // Build context from current scan state
        var ctx = ""
        if !engine.items.isEmpty {
            let total = engine.scannedBytes
            let byCategory = Dictionary(grouping: engine.items, by: { $0.category.rawValue })
                .mapValues { $0.reduce(0) { $0 + $1.size } }
                .sorted { $0.value > $1.value }
                .prefix(5)
                .map { "\($0.key): \(ByteCountFormatter.string(fromByteCount: $0.value, countStyle: .file))" }
                .joined(separator: ", ")
            ctx = "Last scan found \(ByteCountFormatter.string(fromByteCount: total, countStyle: .file)) of junk. Top categories: \(byCategory)."
        }
        Task { await ai.send(userMessage: text, context: ctx) }
    }

    private func handleAction(_ action: AIToolAction) {
        switch action {
        case .runScan:
            Task { await engine.scan() }
        case .cleanAll:
            Task { await engine.clearAll() }
        case .cleanCategory(let cat):
            let toDelete = engine.items.filter { $0.category.rawValue == cat }
            Task { await engine.clear(items: toDelete) }
        case .showSection:
            break // handled by ContentView via notification
        }
    }
}

// MARK: - Message Bubble

private struct MessageBubble: View {
    let message: ChatMessage
    private var isUser: Bool { message.role == "user" }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if isUser { Spacer(minLength: 40) }
            if !isUser {
                ZStack {
                    Circle().fill(Color(hex:"7b5cf0").opacity(0.3)).frame(width: 28, height: 28)
                    Image(systemName: "sparkles").font(.system(size: 12)).foregroundStyle(Color(hex:"7b5cf0"))
                }
            }
            Text(message.content)
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .padding(.horizontal, 14).padding(.vertical, 10)
                .background(
                    isUser ? Color(hex:"7b5cf0").opacity(0.5) : Color.white.opacity(0.08),
                    in: RoundedRectangle(cornerRadius: 16)
                )
            if !isUser { Spacer(minLength: 40) }
        }
    }
}

// MARK: - Thinking Bubble

private struct ThinkingBubble: View {
    @State private var phase = 0

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle().fill(Color(hex:"7b5cf0").opacity(0.3)).frame(width: 28, height: 28)
                Image(systemName: "sparkles").font(.system(size: 12)).foregroundStyle(Color(hex:"7b5cf0"))
            }
            HStack(spacing: 4) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.white.opacity(phase == i ? 0.9 : 0.3))
                        .frame(width: 6, height: 6)
                        .animation(.easeInOut(duration: 0.3), value: phase)
                }
            }
            .padding(.horizontal, 14).padding(.vertical, 12)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
            Spacer()
        }
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 400_000_000)
                phase = (phase + 1) % 3
            }
        }
    }
}
