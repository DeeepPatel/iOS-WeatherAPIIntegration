//Deep Patel - 991584445
//  Deep_WeatherApp.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-10.
//

import SwiftUI

@main
struct Deep_WeatherApp: App {
    let locationHelper = LocationHelper()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationHelper)                
        }
    }
}
