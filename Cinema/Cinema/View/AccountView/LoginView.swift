//
//  LoginView.swift
//  DemoApp
//
//  Created by Dương Duy Khiêm on 9/9/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoginSuccess: Bool
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            headerView
            
            CustomTextField(placeholder: "Nhập số điện thoại", text: $viewModel.numberPhone, placeholderColor: .white)
                .padding()
                .frame(width: 360, height: 50)
                .background(Color.black)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.white.opacity(0.7))
                )
                .accentColor(.white)
                .padding()
            
            otpSection
            
            confirmButton
            
            if viewModel.showToast {
                ToastView(message: viewModel.errorMessage ?? "Đã có lỗi xảy ra")
                    .transition(.opacity)
                    .zIndex(1)
            }
           
            Spacer()
        }
        .background(Color.black)
        .animation(.easeInOut, value: viewModel.showToast)
        .onChange(of: viewModel.isLoginSuccess) { newValue in
            isLoginSuccess = newValue
        }
    }

    private var headerView: some View {
        Text("Thông tin của bạn")
            .font(.system(size: 28, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color(red: 91/255, green: 115/255, blue: 79/255))
    }
    
    private var otpSection: some View {
        HStack {
            CustomTextField(placeholder: "Nhập mã OTP ", text: $viewModel.otpCode, placeholderColor: .white)
                .padding()
                .frame(height: 50)
                .background(Color.black)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.white.opacity(0.7))
                )
                .accentColor(.white)
            
            Button(action: viewModel.sendOTP) {
                Label("Gửi OTP", systemImage: "envelope")
                    .frame(height: 50)
                    .font(.system(size: 14))
                    .padding(.vertical, 1)
                    .padding(.horizontal, 12)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .frame(height: 50)
        }
        .frame(width: 360)
        .padding()
    }
    
    private var confirmButton: some View {
        Button(action: viewModel.verifyOTP) {
            Text("Xác nhận")
                .frame(width: 360, height: 50, alignment: .center)
                .background(Color.green)
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .bold))
                .cornerRadius(3.0)
        }
    }
}

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
    }
}

struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var placeholderColor: UIColor = .white
    var keyboardType: UIKeyboardType = .numberPad

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(_ parent: CustomTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

#Preview {
    LoginView(isLoginSuccess: .constant(false))
}
