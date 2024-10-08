//
//  UploadImageView.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 29/9/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseDatabase

struct UploadImageView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isUploading = false
    @State private var uploadStatus: String = ""
    @State private var tenPhim: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Upload Ảnh Lên Firebase Storage")
                .font(.title)
                .padding()
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
                    .overlay(Text("Chọn ảnh").foregroundColor(.white))
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Chọn Ảnh")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 44)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            TextField("Tên Phim", text: $tenPhim)
                .font(.title)
                .padding()
                .frame(width: 200, height: 50, alignment: .center)

            if let _ = selectedImage {
                Button(action: {
                    uploadImageToFirebase()
                }) {
                    if isUploading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 200, height: 44)
                            .background(Color.green)
                            .cornerRadius(10)
                    } else {
                        Text("Tải Lên")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 44)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .disabled(isUploading)
            }

            Text(uploadStatus)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
        }
        .padding()
    }

    private func uploadImageToFirebase() {
        guard let image = selectedImage else { return }
        isUploading = true
        uploadStatus = "Đang tải lên..."

        let storageRef = Storage.storage().reference().child("AnhPhim/\(UUID().uuidString).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            uploadStatus = "Không thể chuyển đổi ảnh."
            isUploading = false
            return
        }

 
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Xử lý lỗi khi tải lên.
                    self.uploadStatus = "Tải lên thất bại: \(error.localizedDescription)"
                    self.isUploading = false
                } else {
                    storageRef.downloadURL { url, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                self.uploadStatus = "Lấy URL thất bại: \(error.localizedDescription)"
                            } else if let url = url {
                                self.uploadStatus = "Tải lên thành công! URL: \(url.absoluteString)"
                                
                                self.saveImageURLToDatabase(url: url.absoluteString)
                            }
                            // Cập nhật trạng thái tải lên
                            self.isUploading = false
                        }
                    }
                }
            }
        }
    }

    private func saveImageURLToDatabase(url: String) {
        let ref = Database.database().reference().child("DSPhim").child(tenPhim).child("HinhAnh")
        ref.setValue(url) { error, _ in
            if let error = error {
                print("Lỗi khi lưu URL vào Realtime Database: \(error.localizedDescription)")
            } else {
                print("Đã lưu URL thành công vào Realtime Database.")
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

#Preview {
    UploadImageView()
}
