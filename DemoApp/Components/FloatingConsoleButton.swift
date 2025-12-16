import SwiftUI

struct FloatingConsoleButton: View {
    let eventCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "terminal")
                Text("Console")
                if eventCount > 0 {
                    Text("\(eventCount)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.epBackground)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.epCyan)
                        .cornerRadius(10)
                }
            }
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.epCyan)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.epCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.epCyan, lineWidth: 1)
                    )
            )
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 4)
        }
    }
}

#Preview {
    ZStack {
        Color.epBackground.ignoresSafeArea()
        FloatingConsoleButton(eventCount: 5) {}
    }
}
