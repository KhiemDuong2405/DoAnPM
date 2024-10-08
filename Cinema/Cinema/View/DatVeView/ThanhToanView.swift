//
//  ThanhToanView.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 26/9/24.
//

import SwiftUI

struct ThanhToanView: View {
    
    @State private var selectedPaymentMethod: String? = nil
    @State private var isAgreed: Bool = false
    
    var body: some View {
        VStack{
            Text("Tên phim aaaaaaaaaa aaaaaaaaaaaaa")
                .font(.system(size: 34, weight: .bold))
                .padding(.horizontal,20)
                .padding(.top, 10)
                .padding(.bottom,2)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Phân loại")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.red)
                .padding(.horizontal,20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Label("Địa chỉ rạp", systemImage: "mappin")
                .labelStyle(.titleAndIcon)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.horizontal,20)
                .font(.system(size: 16, weight: .light))
            
            Label("Thời gian suất chiếu", systemImage: "calendar")
                .labelStyle(.titleAndIcon)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.horizontal,20)
                .font(.system(size: 16, weight: .light))
            
            Text("1 Vé + 1 Combo")
                .labelStyle(.titleAndIcon)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.horizontal,20)
                .font(.system(size: 16, weight: .light))
            
            Divider()
                .background(Color.white)
            
            Text("Chi tiết đơn hàng")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text("Thông tin ghế")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("100.000đ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,20)
            .padding(.top,5)
            
            HStack{
                Text("Thông tin combo 1")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("100.000đ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,20)
            .padding(.top,5)
            
            HStack{
                Text("Thông tin combo 2")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("100.000đ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,20)
            .padding(.top,5)
            
            Divider()
                .background(Color.white)
            
            HStack{
                Text("Tổng tiền")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("300.000đ")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,20)
            .padding(.vertical,10)
            
            Divider()
                .background(Color.white)
            
            Text("Phương thức thanh toán")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
                .padding(.vertical,10)
            
            HStack{
                Image("LogoZaloPay")
                    .resizable()
                    .frame(width: 46, height: 32)
                
                Text("Thanh toán qua ZaloPay")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if selectedPaymentMethod == "ZaloPay" {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .padding(.horizontal,20)
            .padding(.bottom,10)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedPaymentMethod = "ZaloPay"
            }
            
            HStack{
                Image("LogoApplePay")
                    .resizable()
                    .frame(width: 46, height: 32)
                    .background(Color.white)
                    .cornerRadius(5)
                
                Text("Thanh toán qua Apple Pay")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if selectedPaymentMethod == "ApplePay" {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 24, height: 24)
                    }
                }
               
            }
            .padding(.horizontal,20)
            .padding(.bottom,10)
            .padding(.top,5)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedPaymentMethod = "ApplePay"
            }
            
            Spacer()
            Toggle(isOn: $isAgreed) {
                Text("Tôi đã đọc, hiểu và đồng ý với các điều khoản")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding(.horizontal, 20)
            
            Button(action: {
                            // Hành động thanh toán
            }) {
                Text("Thanh toán")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAgreed && selectedPaymentMethod != nil ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!isAgreed || selectedPaymentMethod == nil)
            .padding()
        }
        .background(Color.black)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(configuration.isOn ? Color.green : Color.white)
                    
                configuration.label
            }
            
        }
    }
}

#Preview {
    ThanhToanView()
}
