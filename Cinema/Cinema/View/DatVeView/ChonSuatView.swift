//
//  ChonSuatView.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 18/9/24.
//

import SwiftUI

struct ChonSuatView: View {
    @StateObject private var viewModel = ThongTinPhimViewModel()
    @StateObject private var chonSuatViewModel = ChonSuatViewModel()
    private var isSelected : Bool = false
    private var city: String = ""
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
    
    var body: some View {
        VStack {
            Image(viewModel.posterImageName)
                .resizable()
                .frame(height: 140)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.movieTitle)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(viewModel.duration)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.white.opacity(0.7))

                }
                
                Spacer()
                
                Text(viewModel.rating)
                    .font(.system(size: 16))
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            .padding(.horizontal, 20)
            .frame(height: 80)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(chonSuatViewModel.dates, id: \.self) { date in
                        Button(action: {
                            chonSuatViewModel.selectedDate = date
                        }) {
                            Text(dateFormatter.string(from: date))
                                .font(.system(size: 14, weight: .bold))
                                .frame(width: 40, height: 40)
                                .background(chonSuatViewModel.selectedDate == date ? Color.green : Color.gray.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                       
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
           
            Divider().background(Color.white)
            
            HStack {
                createCityButton(city: "TPHCM")
                createCityButton(city: "Hà Nội")
                createCityButton(city: "Đà Nẵng")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 5)
            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(chonSuatViewModel.filteredCinemas(for: chonSuatViewModel.selectedCity)) { cinema in
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text(cinema.name)
//                                .font(.system(size: 16, weight: .bold))
//                                .foregroundColor(.white)
//                            
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack (spacing: 10) {
//                                    ForEach(cinema.showtimes, id: \.self) { time in
//                                        NavigationLink(destination: Rap1View()){
//                                            Text(time)
//                                                .font(.system(size: 14))
//                                                .padding(.vertical, 8)
//                                                .padding(.horizontal, 12)
//                                                .background(Color.gray.opacity(0.2))
//                                                .foregroundColor(.white)
//                                                .cornerRadius(4)
//                                        }
//                                    
//                                        Button(action: {
//                                            
//                                        }) {
//                                            
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.horizontal, 20)
//                        
//                        Divider().background(Color.white)
//                    }
//                }
//                .padding(.top, 10)
//            }
            
            Spacer()
        }
        .background(Color.black)
    }
    
    private func createCityButton(city: String) -> some View {
        Button(action: {
            chonSuatViewModel.selectCity(city)
        }) {
            Text(city)
                .font(.system(size: 18, weight: chonSuatViewModel.selectedCity == city ? .bold : .medium))
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(chonSuatViewModel.selectedCity == city ? Color.green : Color.black)
                .foregroundColor(chonSuatViewModel.selectedCity == city ? .white : .gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: chonSuatViewModel.selectedCity == city ? 0 : 1)
                )
                .cornerRadius(5)
        }
        .padding(.horizontal,10)
    }
}

#Preview {
    ChonSuatView()
}
