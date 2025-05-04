import SwiftUI

// MARK: - App Colors
struct MinaColors {
    static let sageGreen = Color(hex: "9B9E8A")
    static let terracotta = Color(hex: "B75E45")
    static let cream = Color(hex: "FAF4F0")
    static let charcoal = Color(hex: "4A4656")
}

// MARK: - Social Auth Configurations
struct SocialAuthConfig {
    static let googleClientId = "YOUR_GOOGLE_CLIENT_ID"
    static let facebookAppId = "YOUR_FACEBOOK_APP_ID"
    static let appleClientId = "YOUR_APPLE_CLIENT_ID"
}

// MARK: - Helper extension for initializing colors with hex values
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
