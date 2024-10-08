//
//  HomeView.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack {
                ImageCarouselView(currentIndex: $viewModel.currentIndex, banners: viewModel.banners)
                
                CategorySelectionView(selectedCategory: $viewModel.selectedCategory)
                
                MovieListView(movies: viewModel.movies, selectedIndex: $viewModel.selectedMovie)
                
                NavigationLink(destination: ThongTinPhimView()) {
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
                    .frame(width: 250, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(5)
                }
                
                Spacer()
            }
            .background(Color.black)
            .onAppear {
                viewModel.loadBanner()
            }
        }
    }
}

struct ImageCarouselView: View {
    @Binding var currentIndex: Int
    let banners: [String]
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(1..<banners.count + 1, id: \.self) { index in
                if let url = URL(string: banners[index-1]) {
                    AsyncImage(url: url) { imagePhase in
                        switch imagePhase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .clipped()
                           
                        case .failure:
                            ProgressView() 
                                .frame(width: 200, height: 200)
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 200)
        .padding(.bottom)
    }
}



struct CategorySelectionView: View {
    @Binding var selectedCategory: String
    
    var body: some View {
        ZStack {
            HStack {
                CategoryButton(title: "Đang chiếu", selectedCategory: $selectedCategory)
                CategoryButton(title: "Sắp chiếu", selectedCategory: $selectedCategory)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .frame(height: 46)
        }
        .background(RoundedRectangle(cornerRadius: 5)
                        .fill(Color(red: 40/255, green: 40/255, blue: 40/255)))
        .padding(.horizontal,10)
    }
}

struct CategoryButton: View {
    let title: String
    @Binding var selectedCategory: String
    
    var body: some View {
        Button(action: {
            selectedCategory = title
        }) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 34)
                .background(selectedCategory == title ? Color(red: 74/255, green: 74/255, blue: 74/255) : Color(red: 40/255, green: 40/255, blue: 40/255))
                .foregroundColor(selectedCategory == title ? Color.white : Color(red: 169/255, green: 169/255, blue: 169/255))
                .cornerRadius(5)
        }
    }
}
struct MovieListView: View {
    let movies: [Cinema]
    @State private var currentIndex = 0
    @Binding var selectedIndex: Int


    var body: some View {
        VStack {
            GeometryReader { geometry in
                TabView(selection: $currentIndex) {
                    ForEach(0..<movies.count, id: \.self) { index in
                        let movie = movies[index]
                        VStack(alignment: .center) {
                            if let url = URL(string: movie.HinhAnh) {
                                AsyncImage(url: url) { imagePhase in
                                    switch imagePhase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 200, height: 300)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200, height: 300)
                                            .cornerRadius(10)
                                            .clipped()
                                    case .failure:
                                        ProgressView()
                                            .frame(width: 200, height: 300)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }

                            Text(movie.TenPhim)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .frame(width: 300, height: 30, alignment: .center)
                                .padding(.top, 10)

                            HStack() {
                                Text("\(movie.ThoiLuong) phút")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)

                                Text(movie.PhanLoai)
                                    .font(.system(size: 16))
                                    .padding(4)
                                    .background(movie.PhanLoai == "P" ? Color.green :Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                            .frame(height: 10)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentIndex) { newValue in
                    currentIndex = newValue
                    selectedIndex = newValue
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 450)
    }
}


#Preview {
    HomeView(viewModel: HomeViewModel())
}
