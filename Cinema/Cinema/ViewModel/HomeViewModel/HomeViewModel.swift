//
//  HomeViewModel.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//
import SwiftUI
import Combine
import FirebaseDatabase
import FirebaseStorage

class HomeViewModel: ObservableObject {
    @Published var currentIndex = 1
    @Published var selectedCategory = "Đang chiếu"
    @Published var movies: [Cinema] = []
    @Published var banners: [String] = []
    @Published var selectedMovie: Int = 0
    
    private var timerSubscription: AnyCancellable?
    
    init() {
        loadBanner()
        loadMovies()
    }
    
    func sendName() -> String {
        return movies[selectedMovie].TenPhim
    }
    
    
    func loadBanner() {
        let storageRef = Storage.storage().reference().child("Banner")

        storageRef.listAll { [weak self] (result, error) in
            guard let self = self else { return }

            if let error = error {
                print("Không thể tải danh sách banners: \(error.localizedDescription)")
                return
            }

            guard let result = result else {
                print("Không có kết quả từ Firebase Storage.")
                return
            }

            var loadedBanners: [String] = []

            let dispatchGroup = DispatchGroup()

            for item in result.items {
                dispatchGroup.enter()
                item.downloadURL { url, error in
                    if let error = error {
                        print("Không thể tải URL banner: \(error.localizedDescription)")
                    } else if let url = url {
                        loadedBanners.append(url.absoluteString)
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                self.banners = loadedBanners
            }
        }
    }

    func loadMovies() {
        let ref = Database.database().reference().child("DSPhim")
        
        ref.observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            
            guard let value = snapshot.value as? [String: [String: Any]] else {
                print("Lỗi lấy dữ liệu từ Firebase.")
                return
            }

            var loadedMovies: [Cinema] = []

            for (tenPhim, data) in value {
                let thoiLuong = "\(data["ThoiLuong"] as? Int ?? 0)"
                let hinhAnh = data["HinhAnh"] as? String ?? ""

                let movie = Cinema(
                    TenPhim: tenPhim,
                    DaoDien: data["DaoDien"] as? String ?? "",
                    DienVien: data["DienVien"] as? String ?? "",
                    KhoiChieu: data["KhoiChieu"] as? String ?? "",
                    MoTa: data["MoTa"] as? String ?? "",
                    NgonNgu: data["NgonNgu"] as? String ?? "",
                    PhanLoai: data["PhanLoai"] as? String ?? "",
                    TheLoai: data["TheLoai"] as? String ?? "",
                    HinhAnh: hinhAnh,
                    ThoiLuong: thoiLuong
                )
                loadedMovies.append(movie)
            }

            DispatchQueue.main.async {
                self.movies = loadedMovies
            }
        }
    }
    
    func updateCurrentIndex() {
        if currentIndex < movies.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }

    func selectCategory(_ category: String) {
        selectedCategory = category
    }
}
