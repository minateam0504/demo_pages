import SwiftUI

struct AIAssistantMessageView: View {
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
                    Text("Mina AI Assistant")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(MinaColors.sageGreen)
                    
                    Text("Just upload your photos, and I'll help you list your item quickly and accurately.")
                        .font(.system(size: 16))
                        .foregroundColor(MinaColors.charcoal)
                    
                    // Photo Tips
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Photo Tips:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(MinaColors.sageGreen)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("• Take clear photos of your item from multiple angles")
                            Text("• Include photos of product labels showing model details")
                            Text("• Capture the expiration date if applicable")
                            Text("• Show any wear or damage clearly")
                        }
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    }
                    .padding(.top, 8)
                    
                    HStack {
                        Image(systemName: "camera")
                            .foregroundColor(MinaColors.sageGreen)
                        Text("Photos of product labels improve accuracy by 85%")
                            .font(.system(size: 12))
                            .foregroundColor(MinaColors.sageGreen)
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