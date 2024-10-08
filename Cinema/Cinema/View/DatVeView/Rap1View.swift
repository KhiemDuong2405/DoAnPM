//
//  Rap1View.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 20/9/24.
//

import SwiftUI

struct Rap1View: View {
    
    @State private var selectedSeats: [String] = []
       
   let rows = ["A", "B", "C", "D", "E", "F", "G", "H"]
   let columns = 1...6
    
    var body: some View {
        VStack{
            Text("Tên Phim")
                .font(.system(size: 30, weight: .medium))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,10)
            
            HStack{
                Text("Rạp 1")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                    .foregroundStyle(.white)
                    .padding(.horizontal,10)
                Spacer()
                
                Text("Thời Lượng")
                    .font(.system(size:  18, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                    .foregroundStyle(.white)
                    .padding(.horizontal,10)
            }
            Image("screen")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .center)
                
            Image("seat")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .center)
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(columns, id: \.self) { column in
                        SeatView(seatNumber: "\(row)\(column)", selectedSeats: $selectedSeats)
                    }
                }
            }
            
            Spacer()
            
            VStack{
                HStack{
                    Text("Ghế")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text("Số tiền")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(.white)
                        
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                NavigationLink(destination: BapNuocView()) {
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
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}

struct SeatView: View {
    var seatNumber: String
    @Binding var selectedSeats: [String]
    
    var body: some View {
        Button(action: {
            if selectedSeats.contains(seatNumber) {
                selectedSeats.removeAll(where: { $0 == seatNumber })
            } else {
                selectedSeats.append(seatNumber)
            }
        }) {
            ZStack {
                Rectangle()
                    .fill(selectedSeats.contains(seatNumber) ? Color.green : Color.gray)
                    .frame(width: 40, height: 40)
                    .cornerRadius(8)
                
                Text(seatNumber)
                    .foregroundColor(.white)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    Rap1View()
}
