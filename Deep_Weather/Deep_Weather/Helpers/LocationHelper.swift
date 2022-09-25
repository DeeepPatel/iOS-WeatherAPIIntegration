// Deep Patel - 991584445
//  LocationHelper.swift
//  Deep_Weather
//
//  Created by Deep on 2021-11-10.
//
import Foundation
import CoreLocation
import MapKit
import Contacts

//File contains code for location and weather api combined
class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var address : String = "unknown"
    @Published var currentLocation : CLLocation?
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var lastSeenLocation: CLLocation?
    
    @Published var currentWeather: Weather?
    
    //custom api url
    
    
    override init() {
        super.init()
        
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        //check for permission
        checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && (self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
        
    }
    
    deinit{
        self.locationManager.stopUpdatingLocation()
    }
    
    func requestPermission(){
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkPermission(){
        print(#function, "Checking for permission")
        
        switch self.locationManager.authorizationStatus{
        case .denied:
            //request permission
            self.requestPermission()
        case .notDetermined:
            self.requestPermission()
        case .restricted:
            self.requestPermission()
        case .authorizedAlways:
            //get location updates
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            //get location updates
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.last != nil{
            //most recent
            
            self.currentLocation = locations.last!
            //updating the API data to match location updates
            self.fetchDataFromAPI(lat: self.currentLocation?.coordinate.latitude ?? 0.0, long: self.currentLocation?.coordinate.longitude ?? 0.0)
            
            
        }else{
            //oldest known
            //updating the API data to match location updates
            self.currentLocation = locations.first
            self.fetchDataFromAPI(lat: self.currentLocation?.coordinate.latitude ?? 0.0, long: self.currentLocation?.coordinate.longitude ?? 0.0)           
            
        }
        
        self.lastSeenLocation = locations.first
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Error: \(error.localizedDescription)")
    }
    
    func fetchDataFromAPI(lat: Double, long: Double){
        //fetchDataFromAPI requires Lat and Long as parameters to pass to api key
        let apiURL = "https://api.weatherapi.com/v1/current.json?key=a403841a4de84253bc932106211111"
        let fullAPI = apiURL + "&q=\(lat),\(long)"
//        print("Latitude:\(lat)")
//        print("Longitude: \(long)")
//        print("api: \(fullAPI)")

        guard let api = URL(string: fullAPI) else{
            print(#function, "Unable to obtain URL from string")
            return
        }

        //Initiate Network call
        URLSession.shared.dataTask(with: api) {(data: Data?, response: URLResponse?, error: Error?) in

            if let error = error{
                print(#function, error)
            }else{
                if let httpReponse = response as? HTTPURLResponse{
                    if httpReponse.statusCode == 200{
                        DispatchQueue.global().async {
                            do{
                                if (data != nil){
                                    if let jsonData = data{

                                        let decoder = JSONDecoder()
                                        var decodedWeather = try decoder.decode(Weather.self, from: jsonData)

                                        if (decodedWeather.conditionIcon != nil){
                                            //Editing the condition Icon url to match Apple's requirements
                                            //Turning a unfinished url into a string then combining https: and then turning it back to a url
                                            let iconURL = decodedWeather.conditionIcon!.absoluteString
                                            let url = "https:" + iconURL
                                            let finalURL = URL(string: url)
                                            self.fetchImage(from: finalURL!, withCompletion: {data in
                                                guard let imageData = data else{
                                                    print(#function, "Image data not obtained")
                                                    return
                                                }

                                                decodedWeather.image = UIImage(data: imageData)

                                                DispatchQueue.main.async {
                                                    self.currentWeather  = decodedWeather
                                                }
                                            })//fetch image
                                        }//if

                                    }else{
                                        print(#function, "No JSON data recieved from API")
                                    }
                                }
                            }catch let error{
                                print(#function, error)
                            }
                        }//dispatchQueue
                    }
                }//let httpresponse
            }//else

        }.resume()
    }
    
    func fetchDataFromAPIHandler(withCompletion completion: @escaping (Weather?) -> Void){
        //fetchDataFromAPI requires Lat and Long as parameters to pass to api key
        let apiURL = "https://api.weatherapi.com/v1/current.json?key=a403841a4de84253bc932106211111"
        let fullAPI = apiURL + "&q=\(self.currentLocation?.coordinate.latitude ?? 0.0),\(self.currentLocation?.coordinate.longitude ?? 0.0)"
        
        //print("api: \(fullAPI)")

        guard let api = URL(string: fullAPI) else{
            print(#function, "Unable to obtain URL from string")
            return
        }

        //Initiate Network call
        URLSession.shared.dataTask(with: api) {(data: Data?, response: URLResponse?, error: Error?) in

            if let error = error{
                print(#function, error)
            }else{
                if let httpReponse = response as? HTTPURLResponse{
                    if httpReponse.statusCode == 200{
                        DispatchQueue.global().async {
                            do{
                                if (data != nil){
                                    if let jsonData = data{

                                        let decoder = JSONDecoder()
                                        var decodedWeather = try decoder.decode(Weather.self, from: jsonData)

                                        if (decodedWeather.conditionIcon != nil){
                                            //Editing the condition Icon url to match Apple's requirements
                                            //Turning a unfinished url into a string then combining https: and then turning it back to a url
                                            let iconURL = decodedWeather.conditionIcon!.absoluteString
                                            let url = "https:" + iconURL
                                            let finalURL = URL(string: url)
                                            self.fetchImage(from: finalURL!, withCompletion: {data in
                                                guard let imageData = data else{
                                                    print(#function, "Image data not obtained")
                                                    return
                                                }

                                                decodedWeather.image = UIImage(data: imageData)

                                                DispatchQueue.main.async {
                                                    self.currentWeather  = decodedWeather
                                                }
                                            })//fetch image
                                        }//if

                                    }else{
                                        print(#function, "No JSON data recieved from API")
                                    }
                                }
                            }catch let error{
                                print(#function, error)
                            }
                        }//dispatchQueue
                    }
                }//let httpresponse
            }//else

        }.resume()
    }

    private func fetchImage(from url: URL, withCompletion completion: @escaping(Data?) -> Void){
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in

            if (data != nil){
                DispatchQueue.main.async {
                    
                    completion(data)
                }
            }
        })
        task.resume()
    }
}
