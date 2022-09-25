//Deep Patel - 991584445
//  Weather.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-10.
//

import Foundation
import UIKit

//Condition Json information
struct Condition: Decodable{
    let text: String
    let icon: URL?
    let code: Int
}

//api weather json information and their properties
struct Weather: Codable{
    let name: String
    let region: String
    let country: String
    let lat: Float
    let lon: Float
    let temp_c: Float
    let feelslike_c: Float
    let wind_kph: Float
    let wind_dir: String
    let humidity: Int
    let uv: Float
    let vis_km: Float
    let conditionText: String
    let conditionIcon: URL?
    var image: UIImage?
    let conditionCode: Int
    
    enum WeatherKeys: String, CodingKey{
        case location
        case current
        
        //Location sub category in the json
        enum LocationKeys: String, CodingKey{
            case name = "name"
            case region = "region"
            case country = "country"
            case lat = "lat"
            case lon = "lon"
        }        
        
        //Current sub category in the json
        enum CurrentKeys: String, CodingKey{
            case temp_c = "temp_c"
            case feelslike_c = "feelslike_c"
            case wind_kph = "wind_kph"
            case wind_dir = "wind_dir"
            case humidity = "humidity"
            case uv = "uv"
            case vis_km = "vis_km"
            case condition
            
            //condition sub category inside the current category in the json
            enum ConditionKeys: CodingKey{
                case text
                case icon
                case code
            }
        }
    }
    
    init(){
        self.name = "Temporary"
        self.region = "Temporary"
        self.country = "Temporary"
        self.lat = 0.0
        self.lon = 0.0
        self.temp_c = 0.0
        self.feelslike_c = 0.0
        self.wind_kph = 0.0
        self.wind_dir = "Temporary"
        self.humidity = 0
        self.uv = 0.0
        self.vis_km = 0.0
        self.conditionText = "Temporary"
        self.conditionIcon = nil
        self.conditionCode = 0
        self.image = nil
    }
    
    init(name: String, region: String, country: String, lat: Float, lon: Float, temp_c: Float, feelslike_c: Float, wind_kph: Float, wind_dir: String, humidity: Int, uv: Float, vis_km: Float, conditionText: String, conditionIcon: URL, image: UIImage, conditionCode: Int){
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.temp_c = temp_c
        self.feelslike_c = feelslike_c
        self.wind_kph = wind_kph
        self.wind_dir = wind_dir
        self.humidity = humidity
        self.uv = uv
        self.vis_km = vis_km
        self.conditionText = conditionText
        self.conditionIcon = conditionIcon
        self.conditionCode = conditionCode
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        //Initializing all the properties from the API data that is required for this app
        let weatherContainer = try decoder.container(keyedBy: WeatherKeys.self)
        
        //Properties within the location sub category in the API data
        let locationContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.LocationKeys.self, forKey: .location)
        
        self.name = try locationContainer.decodeIfPresent(String.self, forKey: .name) ?? "Unavailable"
        self.region = try locationContainer.decodeIfPresent(String.self, forKey: .region) ?? "Unavailable"
        self.country = try locationContainer.decodeIfPresent(String.self, forKey: .country) ?? "Unavailable"
        self.lat = try locationContainer.decodeIfPresent(Float.self, forKey: .lat) ?? 0.0
        self.lon = try locationContainer.decodeIfPresent(Float.self, forKey: .lon) ?? 0.0
        
        //Properties within the current sub category in the API data
        let currentContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.CurrentKeys.self, forKey: .current)
        self.temp_c = try currentContainer.decodeIfPresent(Float.self, forKey: .temp_c) ?? 0.0
        self.feelslike_c = try currentContainer.decodeIfPresent(Float.self, forKey: .feelslike_c) ?? 0.0
        self.wind_kph = try currentContainer.decodeIfPresent(Float.self, forKey: .wind_kph) ?? 0.0
        self.wind_dir = try currentContainer.decodeIfPresent(String.self, forKey: .wind_dir) ?? "Unavailable"
        self.humidity = try currentContainer.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        self.uv = try currentContainer.decodeIfPresent(Float.self, forKey: .uv) ?? 0.0
        self.vis_km = try currentContainer.decodeIfPresent(Float.self, forKey: .vis_km) ?? 0.0

        
        //Properties within the condition sub category in the current category in the API data
        let conditionContainer = try currentContainer.nestedContainer(keyedBy: WeatherKeys.CurrentKeys.ConditionKeys.self, forKey: .condition)
        self.conditionText = try conditionContainer.decodeIfPresent(String.self, forKey: .text) ?? "Unavailable"
        self.conditionIcon = try conditionContainer.decodeIfPresent(URL.self, forKey: .icon) ?? nil
        self.conditionCode = try conditionContainer.decodeIfPresent(Int.self, forKey: .code) ?? 0
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        //nothing to do here
    }
}//struct
