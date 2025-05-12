import SwiftUI

struct ProductDetailsView: View {
    let productDetails: [String: Any]
    let selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    @State private var isEditing = false
    @State private var editedDetails: [String: String] = [:]
    
    var body: some View {
        ZStack {
            MinaColors.cream
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20))
                                .foregroundColor(MinaColors.charcoal)
                        }
                        
                        Spacer()
                        
                        Text("Product Details")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(MinaColors.charcoal)
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    // AI Assistant Message
                    AIAssistantMessageView(
                        message: "I've analyzed your product and filled in the details below. Feel free to edit any information."
                    )
                    
                    // Product Details Card
                    VStack(spacing: 20) {
                        // Product Image
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(8)
                        }
                        
                        // Details Container
                        VStack(spacing: 16) {
                            DetailRow(label: "Name", value: productDetails["ObjectName"] as? String ?? "")
                            DetailRow(label: "Brand", value: productDetails["ObjectBrand"] as? String ?? "")
                            DetailRow(label: "Model", value: productDetails["ObjectModel"] as? String ?? "")
                            DetailRow(label: "Year", value: productDetails["ObjectYear"] as? String ?? "")
                            DetailRow(label: "Condition", value: productDetails["ObjectCondition"] as? String ?? "")
                            DetailRow(label: "Value", value: productDetails["ObjectValue"] as? String ?? "")
                            DetailRow(label: "Description", value: productDetails["ObjectDescription"] as? String ?? "")
                            DetailRow(label: "Safety", value: productDetails["SafetyConsiderations"] as? String ?? "")
                            DetailRow(label: "Features", value: (productDetails["ObjectFeatures"] as? [String])?.joined(separator: ", ") ?? "")
                            DetailRow(label: "Recall", value: (productDetails["HasRecall"] as? Bool) == true ? "Has Recall" : "No Recall")
                            DetailRow(label: "Additional Info", value: productDetails["AdditionalInfo"] as? String ?? "")
                        }
                        .padding(20)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal, 20)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button(action: {
                            isEditing.toggle()
                        }) {
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
                        
                        Button(action: {
                            // Share functionality
                        }) {
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
                    
                    // Continue Button
                    Button(action: {
                        // Handle continue action
                    }) {
                        Text("Continue")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(MinaColors.terracotta)
                            .cornerRadius(24)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(MinaColors.charcoal)
            
            Spacer()
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(
            productDetails: [
                "ObjectName": "Sample Product",
                "ObjectBrand": "Sample Brand",
                "ObjectModel": "Model X",
                "ObjectYear": "2023",
                "ObjectCondition": "Like New",
                "ObjectValue": "$99.99",
                "ObjectDescription": "This is a sample product description.",
                "ObjectFeatures": ["Feature 1", "Feature 2"],
                "SafetyConsiderations": "Safe for children",
                "HasRecall": false,
                "AdditionalInfo": "Some additional information"
            ],
            selectedImage: nil
        )
    }
} 