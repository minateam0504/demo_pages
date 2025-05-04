import SwiftUI

enum SocialLoginType {
    case google, facebook, apple, phone
    
    var title: String {
        switch self {
        case .google: return "Continue with Google"
        case .facebook: return "Continue with Facebook"
        case .apple: return "Continue with Apple"
        case .phone: return "Continue with Phone Number"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .google: return .white
        case .facebook: return Color(hex: "1877F2")
        case .apple: return .black
        case .phone: return MinaColors.sageGreen
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .google: return .black
        case .facebook, .apple, .phone: return .white
        }
    }
    
    var iconName: String {
        switch self {
        case .google: return "g.circle.fill"
        case .facebook: return "f.square.fill"
        case .apple: return "apple.logo"
        case .phone: return "phone.fill"
        }
    }
    
    var iconImage: some View {
        switch self {
        case .google:
            return Image(systemName: "g.circle.fill")
                .foregroundColor(.red)
        case .facebook:
            return Image(systemName: "f.square.fill")
                .foregroundColor(.white)
        case .apple:
            return Image(systemName: "apple.logo")
                .foregroundColor(.white)
        case .phone:
            return Image(systemName: "phone.fill")
                .foregroundColor(.white)
        }
    }
    
    var borderColor: Color? {
        switch self {
        case .google: return Color(UIColor.lightGray)
        default: return nil
        }
    }
}

struct SocialLoginButton: View {
    let type: SocialLoginType
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                type.iconImage
                    .font(.system(size: 20))
                    .frame(width: 24, height: 24)
                
                Text(type.title)
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(type.backgroundColor)
            .foregroundColor(type.foregroundColor)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(type.borderColor ?? Color.clear, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

struct SocialLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            SocialLoginButton(type: .google) {}
            SocialLoginButton(type: .facebook) {}
            SocialLoginButton(type: .apple) {}
            SocialLoginButton(type: .phone) {}
        }
        .padding()
        .background(MinaColors.cream)
        .previewLayout(.sizeThatFits)
    }
}
