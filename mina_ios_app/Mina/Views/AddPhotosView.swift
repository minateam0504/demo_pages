import SwiftUI
import PhotosUI
import AVFoundation

@available(iOS 16.0, *)
struct AddPhotosView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authManager: AuthManager
    @State private var navigateToDetails = false
    @State private var productDetails: [String: Any] = [:]
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSuccessMessage = false
    @State private var showCamera = false
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationStack {
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
                    AIAssistantMessageView(
                        message: "Just upload your photos, and I'll help you list your item quickly and accurately.",
                        tips: [
                            "Take clear photos of your item from multiple angles",
                            "Include photos of product labels showing model details",
                            "Capture the expiration date if applicable",
                            "Show any wear or damage clearly"
                        ],
                        additionalInfo: "Photos of product labels improve accuracy by 85%"
                    )
                    
                    // Photo Display Area
                    PhotoDisplayAreaView(selectedImages: selectedImages)
                    
                    Spacer()
                    
                    // Camera and Gallery Buttons
                    CameraGalleryButtonsView(selectedItems: $selectedItems, onCameraTap: checkCameraPermission)
                        .onChange(of: selectedItems) { newItems in
                            Task {
                                selectedImages = []
                                for item in newItems {
                                    if let data = try? await item.loadTransferable(type: Data.self),
                                       let image = UIImage(data: data) {
                                        selectedImages.append(image)
                                    }
                                }
                            }
                        }
                    
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
            .sheet(isPresented: $showCamera) {
                CameraView(image: $selectedImages)
            }
            .navigationDestination(isPresented: $navigateToDetails) {
                ProductDetailsView(productDetails: productDetails, selectedImage: selectedImages.first)
            }
        }
    }
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            showCamera = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        showCamera = true
                    }
                }
            }
        case .denied, .restricted:
            showError = true
            errorMessage = "Camera access is required to take photos. Please enable it in Settings."
        @unknown default:
            break
        }
    }
    
    private func continueToNextStep() {
        isLoading = true
        
        // Convert first image to Data for upload
        guard let imageData = selectedImages.first?.jpegData(compressionQuality: 0.8) else {
            showError = true
            errorMessage = "No image selected"
            isLoading = false
            return
        }
        
        // Create a URL for your local backend server
        guard let url = URL(string: "http://127.0.0.1:8000/api/process") else {
            showError = true
            errorMessage = "Invalid server URL"
            isLoading = false
            return
        }
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create boundary string for multipart form data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the body of the request
        var body = Data()
        
        // Add the image file
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Add user data
        let userData: [String: Any] = [
            "user_id": "unknown",
            "additional_field": "value"
        ]
        
        if let userDataJson = try? JSONSerialization.data(withJSONObject: userData) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"user_data\"\r\n\r\n".data(using: .utf8)!)
            body.append(userDataJson)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Add the final boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the body of the request
        request.httpBody = body
        
        // Create and start the upload task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    showError = true
                    errorMessage = "Upload failed: \(error.localizedDescription)"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    showError = true
                    errorMessage = "Invalid server response"
                    return
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        productDetails = json
                        let raw_result = json["result"] as? String
                        guard let jsonData = raw_result?.data(using: .utf8) else {
                            print("Invalid or nil JSON string")
                            return
                        }

                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                            print("dictionary is \(String(describing: dictionary))")
                        } catch {
                            print("Failed to parse JSON: \(error)")
                            return
                        }
                        navigateToDetails = true
                    } else {
                        showError = true
                        errorMessage = "Invalid response format"
                    }
                } else {
                    showError = true
                    errorMessage = "Server returned status code \(httpResponse.statusCode)"
                }
            }
        }
        
        task.resume()
    }
}

// Camera View
struct CameraView: UIViewControllerRepresentable {
    @Binding var image: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image.append(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
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
