import SwiftUI

struct ThongTinCaNhanView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = ThongTinCaNhanViewModel()

    var body: some View {
        VStack {
            Text("Cập nhật thông tin")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 30, weight: .bold))
                .padding(.horizontal, 10)
            
            Text("Họ tên")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .medium))
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            TextField("Nhập họ tên", text: $viewModel.hoTen)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 10)
                .submitLabel(.done)
                
            
            Text("Số điện thoại")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .medium))
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            Text(viewModel.getSoDienThoai())
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 10)
            
            Text("Địa chỉ")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .medium))
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            TextField("Nhập địa chỉ", text: $viewModel.diaChi)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 10)
                .submitLabel(.done)
                

            Text("Email")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .medium))
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            TextField("Nhập email", text: $viewModel.eMail)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 10)
                .submitLabel(.done)
                

            Button(action: {
                viewModel.updateInfo()
            }) {
                Text("Cập nhật")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 50)
            .background(Color.green)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.showSuccessAlert) {
            Alert(
                title: Text("Thành công"),
                message: Text("Thông tin đã được cập nhật thành công."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    ThongTinCaNhanView()
}
