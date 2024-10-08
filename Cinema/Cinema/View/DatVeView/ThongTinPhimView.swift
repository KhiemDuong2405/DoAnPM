//
//  ThongTinPhimView.swift
//  DemoApp
//
//  Created by Dương Duy Khiêm on 12/9/24.
//

import SwiftUI

struct ThongTinPhimView: View {
    @ObservedObject private var viewModel = ThongTinPhimViewModel()
    
    
    var body: some View {
        ZStack {
            VStack() {
                Image(viewModel.posterImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                
                Text(viewModel.movieTitle)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.horizontal,10)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                
                Text(viewModel.genre)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.7))
                
                Text("Nội dung")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                
                Text(viewModel.description)
                    .font(.system(size: 16))
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.8))

                MovieDetailRow(label: "Khởi chiếu", value: viewModel.releaseDate)
                MovieDetailRow(label: "Phân loại", value: viewModel.rating, valueColor: .red)
                MovieDetailRow(label: "Ngôn ngữ", value: viewModel.language)
                MovieDetailRow(label: "Đạo diễn", value: viewModel.director)
                MovieDetailRow(label: "Diễn viên", value: viewModel.actors)

                Spacer()

                NavigationLink(destination: ChonSuatView()) {
                    Label {
                        Text("Đặt vé")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    } icon: {
                        Image(systemName: "ticket.fill")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .frame(width: 380, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(5)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
        }
        .background(Color.black)
    }
}

struct MovieDetailRow: View {
    var label: String
    var value: String
    var valueColor: Color = .white

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 5)
                .frame(maxWidth: 100, alignment: .leading)

            Text(value)
                .font(.system(size: 16))
                .foregroundColor(valueColor)
                .frame(maxWidth: .infinity, alignment: .leading)

        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ThongTinPhimView()
}
