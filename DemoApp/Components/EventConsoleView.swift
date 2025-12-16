import SwiftUI

struct TrackedEvent: Identifiable {
    let id = UUID()
    let timestamp: Date
    let name: String
    let parameters: [String: Any]
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: timestamp)
    }
    
    var parametersString: String {
        if parameters.isEmpty { return "{}" }
        let pairs = parameters.map { "\"\($0.key)\": \"\($0.value)\"" }
        return "{ \(pairs.joined(separator: ", ")) }"
    }
}

struct EventConsoleView: View {
    let events: [TrackedEvent]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if events.isEmpty {
                    VStack(spacing: 12) {
                        Text("📊")
                            .font(.system(size: 40))
                            .opacity(0.5)
                        Text("Click any event button to see\ngenerated analytics in action...")
                            .font(.subheadline)
                            .foregroundColor(.epTextMuted)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .padding()
                } else {
                    LazyVStack(spacing: 6) {
                        ForEach(events) { event in
                            EventLineView(event: event)
                                .id(event.id)
                        }
                    }
                    .padding(12)
                    .animation(.easeInOut(duration: 0.2), value: events.count)
                }
            }
            .onChange(of: events.count) { _, _ in
                if let lastEvent = events.last {
                    withAnimation {
                        proxy.scrollTo(lastEvent.id, anchor: .bottom)
                    }
                }
            }
        }
    }
}

struct EventLineView: View {
    let event: TrackedEvent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 6) {
                Text(event.name)
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundColor(.epCyan)

                Spacer()

                Text(event.formattedTime)
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundColor(.epTextMuted)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(event.parametersString)
                .font(.system(size: 12, weight: .regular, design: .monospaced))
                .foregroundColor(.epPurple)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.epBackgroundSecondary)
        .cornerRadius(6)
        .transition(.asymmetric(
            insertion: .move(edge: .leading).combined(with: .opacity),
            removal: .opacity
        ))
    }
}

#Preview {
    ZStack {
        Color.epBackground.ignoresSafeArea()
        EventConsoleView(events: [
            TrackedEvent(timestamp: Date(), name: "Onboarding Screen Shown", parameters: ["origin": "Facebook"]),
            TrackedEvent(timestamp: Date(), name: "Profile Screen Shown", parameters: [:]),
        ])
    }
}
