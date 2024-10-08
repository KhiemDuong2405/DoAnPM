//
//  ContentViewModel.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 14/9/24.
//

import SwiftUI
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoginSuccess: Bool = false

    init() {
        checkLoginStatus()
    }

    func checkLoginStatus() {
        isLoginSuccess = Auth.auth().currentUser != nil
    }

}
