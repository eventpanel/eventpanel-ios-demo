import SwiftUI

extension Color {
    static let epBackground = Color(hex: "0a0a0f")
    static let epBackgroundSecondary = Color(hex: "12121a")
    static let epCard = Color(hex: "1a1a25")
    static let epCardHover = Color(hex: "22222f")
    
    static let epBorder = Color(hex: "2a2a3a")
    static let epBorderActive = Color(hex: "4a4a6a")
    
    static let epTextPrimary = Color(hex: "f0f0f5")
    static let epTextSecondary = Color(hex: "8888a0")
    static let epTextMuted = Color(hex: "5a5a70")
    
    static let epCyan = Color(hex: "00f5d4")
    static let epPink = Color(hex: "ff006e")
    static let epPurple = Color(hex: "8338ec")
    static let epYellow = Color(hex: "ffbe0b")
    static let epBlue = Color(hex: "3a86ff")
    static let epGreen = Color(hex: "06d6a0")
    static let epOrange = Color(hex: "fb5607")
    
    static let dotRed = Color(hex: "ff5f56")
    static let dotYellow = Color(hex: "ffbd2e")
    static let dotGreen = Color(hex: "27c93f")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

enum EventVariant: String, CaseIterable {
    case cyan, green, purple, orange
    
    var color: Color {
        switch self {
        case .cyan: return .epCyan
        case .green: return .epGreen
        case .purple: return .epPurple
        case .orange: return .epOrange
        }
    }
    
    var backgroundColor: Color {
        color.opacity(0.15)
    }
}
