//Deep Patel - 991584445
//  Provider.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-27.
//

import Foundation
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @ObservedObject var locationHelper = LocationHelper()
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(weather: Weather())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(weather: Weather())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        var entries: [WeatherEntry] = []
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: Date()) ?? Date()
        
        //Calling the location helper to acquire current location of the device
        self.locationHelper.fetchDataFromAPI(lat: self.locationHelper.currentLocation?.coordinate.latitude ?? 0.0, long: self.locationHelper.currentLocation?.coordinate.longitude ?? 0.0)
        print(#function, self.locationHelper.currentWeather?.country)
        
        //Adding the current weather information to the weather entry
        entries.append(WeatherEntry(weather: self.locationHelper.currentWeather ?? Weather()))
        
        let timeline = Timeline(entries: entries, policy: .after(refresh))
        completion(timeline)
    }
}
