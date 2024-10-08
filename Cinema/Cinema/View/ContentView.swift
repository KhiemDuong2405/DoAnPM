//
//  ContentView.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 90/255, green: 172/255, blue: 0/255, alpha: 1)
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 90/255, green: 172/255, blue: 0/255, alpha: 1)]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label("Trang chủ", systemImage: "house")
                }
            
            UploadImageView()
                .tabItem {
                    Label("Cửa hàng", systemImage: "cart")
                }
            
            NavigationStack {
                if contentViewModel.isLoginSuccess {
                    AccountView(isLoginSuccess: $contentViewModel.isLoginSuccess)
                } else {
                    LoginView(isLoginSuccess: $contentViewModel.isLoginSuccess)
                }
            }
            .tabItem {
                Label("Tài khoản", systemImage: "person")
            }
        }
        
        .onAppear {
            contentViewModel.checkLoginStatus()
        }
    }
}

#Preview {
    ContentView()
}
