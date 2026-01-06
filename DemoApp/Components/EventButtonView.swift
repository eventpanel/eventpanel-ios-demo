import SwiftUI

struct EventButtonView: View {
    let label: String
    let badges: [String]
    let variant: EventVariant
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        } label: {
            ViewThatFits {
                HStack {
                    TitleView(label: label)

                    Spacer()

                    HStack(spacing: 6) {
                        ForEach(badges, id: \.self) { badge in
                            BadgeView(badge: badge, variant: variant)
                        }
                    }
                }

                VStack(alignment: .leading) {
                    TitleView(label: label)

                    HStack(spacing: 6) {
                        ForEach(badges, id: \.self) { badge in
                            BadgeView(badge: badge, variant: variant)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.epCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isPressed ? variant.color : Color.epBorder, lineWidth: 1)
                    )
            )
            .shadow(color: isPressed ? variant.color.opacity(0.3) : .clear, radius: 10)
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

private struct TitleView: View {
    let label: String

    var body: some View {
        Text(label)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.epTextPrimary)
    }
}

private struct BadgeView: View {
    let badge: String
    let variant: EventVariant

    var body: some View {
        Text(badge)
            .font(.system(size: 11, weight: .medium, design: .monospaced))
            .foregroundColor(variant.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(variant.backgroundColor)
            .cornerRadius(6)
    }
}

#Preview {
    ZStack {
        Color.epBackground.ignoresSafeArea()
        VStack(spacing: 8) {
            EventButtonView(label: "Test Event", badges: ["param"], variant: .cyan) {}
            EventButtonView(label: "Another Event", badges: ["a", "b"], variant: .green) {}
        }
        .padding()
    }
}
