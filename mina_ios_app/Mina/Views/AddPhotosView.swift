import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct AddPhotosView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authManager: AuthManager
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSuccessMessage = false
    
    var body: some View {
        ZStack {
            MinaColors.cream
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Back button and title
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundColor(MinaColors.charcoal)
                    }
                    
                    Spacer()
                    
                    Text("Add Photos")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(MinaColors.charcoal)
                    
                    Spacer()
                }
                .padding(.top, 10)
                
                // AI Assistant Message
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
                
                // Photo Upload Area
                VStack(spacing: 20) {
                    if selectedImages.isEmpty {
                        // Upload Area
                        VStack(spacing: 16) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 48))
                                .foregroundColor(MinaColors.sageGreen)
                            
                            Text("Upload Photos")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(MinaColors.charcoal)
                            
                            Text("Take or select photos of your item")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [5]))
                        )
                        .onTapGesture {
                            // Open photo picker
                        }
                    } else {
                        // Selected Images
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180, height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Additional Photo Buttons
                    HStack(spacing: 10) {
                        Button(action: {
                            // Add label photo
                        }) {
                            HStack {
                                Image(systemName: "camera")
                                Text("Add Label Photo")
                            }
                            .font(.system(size: 14))
                            .foregroundColor(MinaColors.charcoal)
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        Button(action: {
                            // Upload more photos
                        }) {
                            HStack {
                                Image(systemName: "photo.on.rectangle")
                                Text("Upload More")
                            }
                            .font(.system(size: 14))
                            .foregroundColor(MinaColors.charcoal)
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Camera and Gallery Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // Open camera
                    }) {
                        HStack {
                            Image(systemName: "camera")
                            Text("Take Photo")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(MinaColors.charcoal)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Button(action: {
                        // Open gallery
                    }) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text("Gallery")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(MinaColors.charcoal)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 20)
                
                // Continue Button
                Button(action: {
                    continueToNextStep()
                }) {
                    ZStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Continue")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(16)
                .background(selectedImages.isEmpty ? Color.gray : MinaColors.terracotta)
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .disabled(selectedImages.isEmpty || isLoading)
                .padding(.bottom, 30)
            }
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .overlay(
            Group {
                if showSuccessMessage {
                    VStack {
                        Spacer()
                        Text("Photo added successfully!")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(MinaColors.sageGreen)
                            .cornerRadius(8)
                            .padding(.bottom, 100)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showSuccessMessage)
                }
            }
        )
    }
    
    private func continueToNextStep() {
        isLoading = true
        
        // TODO: Upload photos to Firebase Storage
        // For now, just dismiss
        presentationMode.wrappedValue.dismiss()
        
        isLoading = false
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            AddPhotosView()
                .environmentObject(AuthManager.shared)
        } else {
            // Fallback on earlier versions
        }
    }
} 
