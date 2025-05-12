import SwiftUI

struct AIAssistantMessageView: View {
    let title: String
    let message: String
    let tips: [String]?
    let additionalInfo: String?
    
    init(
        title: String = "Mina AI Assistant",
        message: String,
        tips: [String]? = nil,
        additionalInfo: String? = nil
    ) {
        self.title = title
        self.message = message
        self.tips = tips
        self.additionalInfo = additionalInfo
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                // AI Avatar
                Circle()
                    .fill(MinaColors.sageGreen)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("M")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(MinaColors.sageGreen)
                    
                    Text(message)
                        .font(.system(size: 16))
                        .foregroundColor(MinaColors.charcoal)
                    
                    // Photo Tips
                    if let tips = tips {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Photo Tips:")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(MinaColors.sageGreen)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(tips, id: \.self) { tip in
                                    Text("• \(tip)")
                                }
                            }
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        }
                        .padding(.top, 8)
                    }
                    
                    if let additionalInfo = additionalInfo {
                        HStack {
                            Image(systemName: "camera")
                                .foregroundColor(MinaColors.sageGreen)
                            Text(additionalInfo)
                                .font(.system(size: 12))
                                .foregroundColor(MinaColors.sageGreen)
                        }
                    }
                }
            }
            .padding(16)
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(MinaColors.sageGreen.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.horizontal, 20)
    }
} 