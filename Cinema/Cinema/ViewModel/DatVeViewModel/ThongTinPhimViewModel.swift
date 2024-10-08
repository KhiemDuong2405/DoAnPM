//
//  ThongTinPhimViewModel.swift
//  DemoApp
//
//  Created by Dương Duy Khiêm on 15/9/24.
//

import SwiftUI

class ThongTinPhimViewModel: ObservableObject {
    @Published var movieTitle: String = "MA DA"
    @Published var genre: String = "Horror, Thriller"
    @Published var description: String = "Truyền thuyết tâm linh bí ẩn của vùng sông nước Việt Nam được mang lên màn ảnh rộng. Một oan hồn cư ngụ dưới dòng nước, một linh hồn vô tội khác phải thế mạng..."
    @Published var releaseDate: String = "16 tháng 08, 2024"
    @Published var rating: String = "16+"
    @Published var duration: String = "120 phút"
    @Published var language: String = "Phụ đề tiếng Anh"
    @Published var director: String = "Nguyễn Hữu Hoàng"
    @Published var actors: String = "Việt Hương, Trung Dân, NSƯT Thành Lộc, Cẩm Ly"
    @Published var posterImageName: String = "1"
    
    
    
}
