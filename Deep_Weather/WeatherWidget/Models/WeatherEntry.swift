// Deep Patel - 991584445
//  WeatherEntry.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-27.
//

import Foundation
import WidgetKit

struct WeatherEntry: TimelineEntry {
    //Entry class that will take date and Weather class
    let date = Date()
    let weather: Weather
}
