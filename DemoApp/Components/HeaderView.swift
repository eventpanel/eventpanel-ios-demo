import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .center, spacing: 8) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                
                Text("Type-safe analytics events for Swift")
                    .font(.subheadline)
                    .foregroundColor(.epTextSecondary)
            }
        }
        .padding(.top, 20)
    }
}

#Preview {
    ZStack {
        Color.epBackground.ignoresSafeArea()
        HeaderView()
    }
}
