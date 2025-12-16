import SwiftUI

struct EventCardView<Content: View>: View {
    let title: String
    let icon: String
    let variant: EventVariant
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Text(icon)
                    .font(.title2)
                    .frame(width: 40, height: 40)
                    .background(variant.backgroundColor)
                    .cornerRadius(10)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.epTextPrimary)
            }
            
            VStack(spacing: 8) {
                content()
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.epCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.epBorder, lineWidth: 1)
                )
        )
    }
}

#Preview {
    ZStack {
        Color.epBackground.ignoresSafeArea()
        EventCardView(title: "Test Card", icon: "🚀", variant: .cyan) {
            Text("Content here")
                .foregroundColor(.epTextSecondary)
        }
        .padding()
    }
}
