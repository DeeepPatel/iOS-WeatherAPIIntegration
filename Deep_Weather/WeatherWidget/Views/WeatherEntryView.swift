//Deep Patel - 991584445
//  WeatherEntryView.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-27.
//

import Foundation
import SwiftUI

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack{
            //Vstack to display all the information required
            HStack{
                Text("\(entry.weather.name)")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.title)
            }
            HStack{
                Text("Temperature:")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text("\(entry.weather.temp_c, specifier: "%.2f") °C")
                    .fontWeight(.bold)
            }
            
            HStack{
                Text("Condition:")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text("\(entry.weather.conditionText)")
                    .fontWeight(.bold)
            }
            Image(uiImage: entry.weather.image ?? UIImage())
                .frame(maxWidth: .infinity, alignment: .center)
        }//VStack
    }
}
