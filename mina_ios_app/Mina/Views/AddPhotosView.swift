import SwiftUI
import PhotosUI

struct AddPhotosView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authManager: AuthManager
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            MinaColors.cream
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Back button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(MinaColors.charcoal)
                    }
                    Spacer()
                }
                .padding(.top, 10)
                
                // Logo
                MinaLogo(size: .medium)
                
                // Title
                Text("Add Your Photos")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(MinaColors.charcoal)
                
                // Subtitle
                Text("Add a profile photo to help other users recognize you")
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(MinaColors.charcoal)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Photo Selection Area
                VStack(spacing: 20) {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(MinaColors.terracotta, lineWidth: 3)
                            )
                    } else {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 200, height: 200)
                            .overlay(
                                Circle()
                                    .stroke(MinaColors.terracotta, lineWidth: 3)
                            )
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(MinaColors.terracotta)
                            )
                    }
                    
                    PhotosPicker(selection: $selectedItem,
                               matching: .images,
                               photoLibrary: .shared()) {
                        Text(selectedImage == nil ? "Select Photo" : "Change Photo")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(MinaColors.terracotta)
                    }
                }
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    continueToMainApp()
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
                .background(MinaColors.terracotta)
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .disabled(isLoading)
                
                // Skip Option
                Button(action: {
                    continueToMainApp()
                }) {
                    Text("Skip for now")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .underline()
                }
                .padding(.top, 12)
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImage = image
                }
            }
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func continueToMainApp() {
        isLoading = true
        
        // TODO: Upload photo to Firebase Storage if selected
        if let image = selectedImage {
            // Upload image and then dismiss
            // For now, just dismiss
            presentationMode.wrappedValue.dismiss()
        } else {
            // No image selected, just dismiss
            presentationMode.wrappedValue.dismiss()
        }
        
        isLoading = false
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotosView()
            .environmentObject(AuthManager.shared)
    }
} 