//
//  AccountViewModel.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI
import FirebaseAuth
import CoreImage.CIFilterBuiltins

class AccountViewModel: ObservableObject {
    @Published var username: String = "Nguyễn Văn Abcd"
    @Published var phoneNumber: String = "0123456789"
    @Published var loyaltyPoints: Int = 0
    @Published var qrCodeImage: UIImage? = nil
    @Published var isLoginSuccess: Bool = true 

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    init() {
        generateQRCode(from: "01")
    }
    
    func generateQRCode(from string: String) {
        let data = Data(string.utf8)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return }
        filter.setValue(data, forKey: "inputMessage")
        
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let outputImage = filter.outputImage else { return }
        let scaleX = 300 / outputImage.extent.size.width
        let scaleY = 300 / outputImage.extent.size.height
        let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        if let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) {
            self.qrCodeImage = UIImage(cgImage: cgImage)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            isLoginSuccess = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
