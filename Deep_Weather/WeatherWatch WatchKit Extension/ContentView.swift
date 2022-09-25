//Deep Patel - 991584445
//  ContentView.swift
//  WeatherWatch WatchKit Extension
//
//  Created by Deep on 2021-11-27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationHelper: LocationHelper
    
    var body: some View {
        VStack{
            //vstack to display all the information required
            HStack{
                Text("\(self.locationHelper.currentWeather?.name ?? "")")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .font(.title)
            }
            HStack{
                Text("Temperature:")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text("\(self.locationHelper.currentWeather?.temp_c ?? 0.0, specifier: "%.2f") °C")
                    .fontWeight(.bold)
            }
            HStack{
                Text("\(self.locationHelper.currentWeather?.conditionText ?? "")")
                    .fontWeight(.bold)
                    
            }
            Image(uiImage: locationHelper.currentWeather?.image ?? UIImage())
                .frame(maxWidth: .infinity, alignment: .center)
        }//VStack
        .onAppear{
            self.locationHelper.fetchDataFromAPI(lat: self.locationHelper.currentLocation?.coordinate.latitude ?? 0.0, long: self.locationHelper.currentLocation?.coordinate.longitude ?? 0.0)
        }//onAppear
    }//body
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
