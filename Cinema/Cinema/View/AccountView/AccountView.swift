//
//  AccountView.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI

struct AccountView: View {
    @Binding var isLoginSuccess: Bool
    @StateObject private var viewModel = AccountViewModel()

    var body: some View {
        VStack {
            Text("Thông tin của bạn")
                .frame(maxWidth: .infinity)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
            GeometryReader { geometry in
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.username)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width / 2, alignment: .leading)
                            .padding(10)
                        
                        Text(viewModel.phoneNumber)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width / 2, alignment: .leading)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Text("Điểm tích luỹ:")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text("\(viewModel.loyaltyPoints)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        
                        Spacer()
                    }
                    .frame(height: 120)
                    
                    if let qrImage = viewModel.qrCodeImage {
                        Image(uiImage: qrImage)
                            .resizable()
                            .interpolation(.none)
                            .frame(width: 120, height: 120)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
            }
            .frame(height: 150)
            
            Divider()
                .background(Color.white)
            
            VStack {
                NavigationLink(destination: ThongTinCaNhanView()) {
                    navigationItem(icon: "person.circle", title: "Thông tin cá nhân")
                }
                
                Divider()
                    .background(Color.white)
                
                NavigationLink(destination: LichSuThanhToanView()) {
                    navigationItem(icon: "clock.arrow.circlepath", title: "Vé đã mua")
                }
                
                Divider()
                    .background(Color.white)
                
                Button(action: {
                    
                }) {
                    navigationItem(icon: "gift", title: "Ưu đãi thành viên")
                }
                
                Divider()
                    .background(Color.white)
            }
            .padding(.horizontal, 20)
            
            Button(action: {
                viewModel.logout()
                isLoginSuccess = viewModel.isLoginSuccess
            }) {
                navigationItem(icon: "arrow.right.square", title: "Đăng xuất")
            }
            .padding(.horizontal, 20)
            
            Divider()
                .background(Color.white)
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func navigationItem(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
        .padding(.vertical, 10)
        .background(Color.clear)
        .cornerRadius(10)
    }
}

#Preview {
    AccountView(isLoginSuccess: .constant(true))
}
