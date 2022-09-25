//Deep Patel - 991584445
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Deep on 2021-11-27.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidget: Widget {
    let kind: String = "com.deeppatel.Deep_Weather.WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This is a widget to display weather.")
        .supportedFamilies([.systemLarge, .systemMedium])
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetEntryView(entry: WeatherEntry(weather: Weather()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
