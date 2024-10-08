//
//  ThongTinCaNhanViewModel.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ThongTinCaNhanViewModel: ObservableObject {
    @Published var hoTen: String = ""
    @Published var soDienThoai: String = ""
    @Published var diaChi: String = ""
    @Published var eMail: String = ""
    @Published var showSuccessAlert: Bool = false

    private var ref: DatabaseReference = Database.database().reference()
    
    init() {
        fetchUserPhoneNumber()
        fetchUserInfo()
    }
    
    private func fetchUserPhoneNumber() {
        if let currentUser = Auth.auth().currentUser {
            soDienThoai = currentUser.phoneNumber ?? ""
        }
    }
    
    func getSoDienThoai() -> String {
        if soDienThoai.hasPrefix("+84") {
            let localPhoneNumber = "0" + soDienThoai.dropFirst(3)
            return localPhoneNumber
        } else {
            return soDienThoai
        }
    }
    
    func fetchUserInfo() {
        guard !soDienThoai.isEmpty else { return }
        
        ref.child("users").child(soDienThoai).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                self.hoTen = data["name"] as? String ?? ""
                self.diaChi = data["address"] as? String ?? ""
                self.eMail = data["email"] as? String ?? ""
            }
        }
    }
    
    func updateInfo() {
        guard !soDienThoai.isEmpty else { return }
        
        ref.child("users").child(soDienThoai).updateChildValues([
            "name": self.hoTen,
            "address": self.diaChi,
            "email": self.eMail
        ]) { error, _ in
            if let error = error {
                print("Lỗi khi cập nhật dữ liệu: \(error.localizedDescription)")
            } else {
                self.showSuccessAlert = true
            }
        }
    }
}
