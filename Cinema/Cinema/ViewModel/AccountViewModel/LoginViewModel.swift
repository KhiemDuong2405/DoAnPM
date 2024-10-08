//
//  LoginViewModel.swift
//  DemoApp
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var numberPhone: String = ""
    @Published var otpCode: String = ""
    @Published var errorMessage: String?
    @Published var verifyOTPcode: String? = nil
    @Published var showToast: Bool = false
    @Published var isLoginSuccess: Bool = false
    
    func checkNumber() -> Bool {
        var formattedPhoneNumber = numberPhone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if formattedPhoneNumber.hasPrefix("0") {
            formattedPhoneNumber = String(formattedPhoneNumber.dropFirst())
        }
        
        if formattedPhoneNumber.count == 9 {
            phoneNumber = "+84" + formattedPhoneNumber
            return true
        } else {
            errorMessage = "Số điện thoại không hợp lệ. Vui lòng nhập lại."
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showToast = false
            }
            return false
        }
    }
    
    func sendOTP() {
        if !checkNumber() {
            return
        } else {
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if error != nil {
                    self.errorMessage = "Không thể gửi mã xác minh"
                    self.showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showToast = false
                    }
                    return
                }
                self.errorMessage = "Mã xác minh đã được gửi"
                self.showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showToast = false
                }
                self.verifyOTPcode = verificationID
            }
        }
    }
    
    func verifyOTP() {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verifyOTPcode ?? "",
            verificationCode: otpCode
        )
        Auth.auth().signIn(with: credential) { authData, error in
            if error != nil {
                self.errorMessage = "Xác minh OTP thất bại"
                self.showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showToast = false
                }
                return
            }
            
            self.errorMessage = "Đăng nhập thành công"
            self.showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showToast = false
                self.isLoginSuccess = true
            }
        }
    }
}
