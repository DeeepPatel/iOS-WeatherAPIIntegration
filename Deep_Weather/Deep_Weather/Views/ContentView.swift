//Deep Patel - 991584445
//  ContentView.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-10.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var locationHelper: LocationHelper
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Form{
                    Section(header: Text("Location")){
                        HStack{
                            Text("City:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.name ?? "")")
                        }
                        
                        HStack{
                            Text("Region:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.region ?? "")")
                        }
                        HStack{
                            Text("Country:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.country ?? "")")
                        }
                        HStack{
                            Text("Latitude:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.lat ?? 0.0)")
                        }
                        HStack{
                            Text("Longitude:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.lon ?? 0.0)")
                        }
                    }//location section
                    
                    Section(header: Text("Condition")){
                        HStack{
                            Text("Condition:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.conditionText ?? "")")
                        }
                        Image(uiImage: locationHelper.currentWeather?.image ?? UIImage())
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }//condition section
                    
                    Section(header: Text("Current Information")){
                        HStack{
                            Text("Temperature:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.temp_c ?? 0.0, specifier: "%.2f") °C")
                        }
                        HStack{
                            Text("Feels like:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.feelslike_c ?? 0.0, specifier: "%.2f") °C")
                        }
                        HStack{
                            Text("Wind:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.wind_kph ?? 0.0, specifier: "%.2f") kph")
                        }
                        HStack{
                            Text("Humidity:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.humidity ?? 0)")
                        }
                        HStack{
                            Text("UV Index:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.uv ?? 0.0, specifier: "%.2f")")
                        }
                        HStack{
                            Text("Visibility:")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("\(self.locationHelper.currentWeather?.vis_km ?? 0.0, specifier: "%.2f") km")
                        }
                    }//current information section
                }
            }//vstack
            .onAppear{
                getCoordinates()
            }
            .navigationBarTitle("Deep Patel")
        }//navigationView
        
        
    }//body
    private func getCoordinates(){
        locationHelper.fetchDataFromAPI(lat: self.locationHelper.currentLocation?.coordinate.latitude ?? 0.0, long: self.locationHelper.currentLocation?.coordinate.longitude ?? 0.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
