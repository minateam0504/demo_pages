import SwiftUI

struct ProductDetailsButtonsView: View {
    let onEditTap: () -> Void
    let onShareTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onEditTap) {
                Image(systemName: "pencil")
                    .font(.system(size: 20))
                    .foregroundColor(MinaColors.charcoal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            
            Button(action: onShareTap) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
                    .foregroundColor(MinaColors.charcoal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 20)
    }
} 