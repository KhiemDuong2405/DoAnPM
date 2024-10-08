//
//  ChonSuatViewModel.swift
//  Cinema
//
//  Created by Dương Duy Khiêm on 18/9/24.
//

import SwiftUI
import Combine

class ChonSuatViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var cinemas: [Cinema] = []
    @Published var dates: [Date] = []
    @Published var selectedCity: String = "TPHCM"

    
    init() {
        fetchDates()
        loadCinemas()
    }
    
    func fetchDates() {
        let today = Date()
        let calendar = Calendar.current
        dates = (0..<6).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: today)
        }
    }
    
    func loadCinemas() {
        
    }
    
    func selectCity(_ city: String) {
        selectedCity = city
    }
    
    
}


