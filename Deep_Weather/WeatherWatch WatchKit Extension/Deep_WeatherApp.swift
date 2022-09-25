//Deep Patel - 991584445
//  Deep_WeatherApp.swift
//  WeatherWatch WatchKit Extension
//
//  Created by Deep on 2021-11-27.
//

import SwiftUI

@main
struct Deep_WeatherApp: App {
    //creating variable to hold locationHelper class to pass as environment object
    let locationHelper = LocationHelper()
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(locationHelper)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
