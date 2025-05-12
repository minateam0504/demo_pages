import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct CameraGalleryButtonsView: View {
    @Binding var selectedItems: [PhotosPickerItem]
    let onCameraTap: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onCameraTap) {
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
            
            PhotosPicker(selection: $selectedItems,
                       maxSelectionCount: 3,
                       matching: .images) {
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
    }
} 
