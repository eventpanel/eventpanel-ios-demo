import SwiftUI

struct ConsoleModalView: View {
    let events: [TrackedEvent]
    let onClear: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            Color.epBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Text("Console")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.epTextPrimary)
                        .padding(.leading, 8)

                    Spacer()
                    
                    Button("Clear", action: onClear)
                        .font(.subheadline)
                        .foregroundColor(.epTextSecondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.epBorder, lineWidth: 1)
                        )
                    
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.epTextSecondary)
                    }
                    .padding(.leading, 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.epBackgroundSecondary)
                
                EventConsoleView(events: events)
            }
        }
    }
}

#Preview {
    ConsoleModalView(
        events: [
            TrackedEvent(timestamp: Date(), name: "Test Event", parameters: ["key": "value"])
        ],
        onClear: {},
        onClose: {}
    )
}
