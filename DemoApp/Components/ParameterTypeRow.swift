import SwiftUI

struct ParameterTypeRow: View {
    let icon: String
    let type: String
    let example: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(icon)
            VStack(alignment: .leading, spacing: 2) {
                Text(type)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.epTextPrimary)
                Text(example)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.epTextMuted)
            }
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        Color.epBackground.ignoresSafeArea()
        VStack {
            ParameterTypeRow(icon: "🔹", type: "Enum", example: "Origin: Facebook, Insta")
            ParameterTypeRow(icon: "🔸", type: "Optional String", example: "cityId: String?")
        }
        .padding()
    }
}
