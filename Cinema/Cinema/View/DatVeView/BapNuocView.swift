import SwiftUI

struct BapNuocView: View {
    @State private var comboPartyCount: Int = 0
    @State private var comboCoupleCount: Int = 0
    @State private var comboSoloCount: Int = 0

    var body: some View {
        VStack {
            Text("Combo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.leading, 20)

            // Combo Party
            comboView(
                imageName: "family",
                title: "Combo Party",
                price: "169.000đ",
                count: $comboPartyCount
            )
            
            // Combo Couple
            comboView(
                imageName: "couple",
                title: "Combo Couple",
                price: "119.000đ",
                count: $comboCoupleCount
            )
            
            // Combo Solo
            comboView(
                imageName: "single",
                title: "Combo Solo",
                price: "99.000đ",
                count: $comboSoloCount
            )

            Spacer()

            VStack {
                HStack {
                    Text("Số ghế")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(.white)

                    Spacer()

                    Text("Số tiền")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                NavigationLink(destination: ThanhToanView()) {
                    Text("Tiếp tục")
                        .padding(.horizontal, 150)
                        .padding(.vertical, 10)
                        .font(.system(size: 20, weight: .medium))
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.vertical, 5)
                .padding(.bottom, 10)
            }
            .background(Color.white.opacity(0.2))
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.bottom, 10)
        }
        .background(Color.black)
    }
    
    // Hàm tạo giao diện cho mỗi combo
    @ViewBuilder
    private func comboView(imageName: String, title: String, price: String, count: Binding<Int>) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)

            Spacer()

            VStack {
                Text(title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)

                HStack {
                    Button(action: {
                        if count.wrappedValue > 0 {
                            count.wrappedValue -= 1
                        }
                    }) {
                        Text("-")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(count.wrappedValue > 0 ? .green : .gray)
                            .frame(width: 16, height: 16)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(count.wrappedValue > 0 ? Color.green : Color.gray, lineWidth: 2)
                                   
                            )
                    }
                    .disabled(count.wrappedValue == 0)

                    Text("\(count.wrappedValue)")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .light))
                        .padding(5)

                    Button(action: {
                        count.wrappedValue += 1
                    }) {
                        Text("+")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.green)
                            .frame(width: 16, height: 16)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }

                    Spacer()

                    Text(price)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 10)
                .frame(maxHeight: 50)
            }
        }
        .padding()
        .background(Color(red: 40 / 255, green: 40 / 255, blue: 40 / 255))
        .cornerRadius(10)
    }
}

#Preview {
    BapNuocView()
}
