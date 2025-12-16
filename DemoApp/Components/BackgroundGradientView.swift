import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        ZStack {
            Color.epBackground
            
            RadialGradient(
                colors: [Color.epCyan.opacity(0.08), .clear],
                center: .topLeading,
                startRadius: 0,
                endRadius: 400
            )
            
            RadialGradient(
                colors: [Color.epPurple.opacity(0.08), .clear],
                center: .topTrailing,
                startRadius: 0,
                endRadius: 400
            )
            
            RadialGradient(
                colors: [Color.epPink.opacity(0.05), .clear],
                center: .bottom,
                startRadius: 0,
                endRadius: 500
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundGradientView()
}
