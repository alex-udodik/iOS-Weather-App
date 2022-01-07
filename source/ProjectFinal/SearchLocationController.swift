//
//  SearchLocationController.swift
//  ProjectFinal
//
//  Created by Alex on 4/20/21.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class SearchLocationController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var textFieldAddLocation: UITextField!
    
    var text: String?
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    var lon: Float?
    var lat: Float?
    var city: String?
    var country: String?
    var cityID: Int?
    
    var locationManager = CLLocationManager()
    
    var userLocation: CLLocation!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SearchLocationController")
        textFieldAddLocation.delegate = self
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func buttonUseMyCurrentLocation(_ sender: UIButton) {
        initializeLocation()
        
        if let lat = userLocation.coordinate.latitude as? String {
            if let lon = userLocation.coordinate.longitude as? String {
                getLocationCoordinate(lat: lat, lon: lon)
            }
            
        }
        
    }
    
    func initializeLocation() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("location authorized")
            
            if let location = locationManager.location?.coordinate {
                userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            }
            
        case .denied, .restricted:
            print("location not authorized")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("unknown location authorization")
        }
    }
    @IBAction func onTextFieldChange(_ sender: UITextField) {
        text = textFieldAddLocation.text
    }
    
    func getLocation(location: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=" + location + "&appid=87a2f4bbfb5d44364ab455c8a3aa1300"
        
        let url = URL(string: urlString)
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: handleResponse)
        dataTask.resume()
    }
    
    func getLocationCoordinate(lat: String, lon: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&" + "lon=" + lon + "&appid=87a2f4bbfb5d44364ab455c8a3aa1300"
        
        let url = URL(string: urlString)
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: handleResponse)
        dataTask.resume()
    }
    
    func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        
        if let err = error {
            print("error: \(err.localizedDescription)")
            DispatchQueue.main.async {
                self.showAlert()

            }
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("error: improperly-formatted response")
            DispatchQueue.main.async {
                self.showAlert()

            }
            return
        }
        
        let statusCode = httpResponse.statusCode
        
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            DispatchQueue.main.async {
                self.showAlert()

            }
            return
        }
        
        guard  let somedata = data else {
            print("error: no data")
            DispatchQueue.main.async {
                self.showAlert()

            }
            return
        }
        
        guard let dataStr = String(data: somedata, encoding: .utf8) else {
            print("error: improperly-formatted data")
            DispatchQueue.main.async {
                self.showAlert()

            }
            return
        }
        
        print("success: response \(dataStr)")
        
        //here we are successful and do not have to provide an alert.
        
        //simply pack the location data into a class and save using coredata.
        
        
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata),
              let jsonDict = jsonObj as? [String: Any],
              let coord = jsonDict["coord"] as? [String: Any]
               else {
            print("error: invalid JSON data")
            DispatchQueue.main.async {
                self.showAlert()

            }
            return
        }
        
        var lat : Float = 0.0
        var lon : Float = 0.0
        var country = "default"
        var city = "default"
        var cityid : Int = 0
                
        if let temp = coord["lat"] as? Double {
            lat = Float(temp)
        }
        
        if let temp = coord["lon"] as? Double {
            lon = Float(temp)
        }
        
        if let sys = jsonDict["sys"] as? [String: Any] {
            if let temp = sys["country"] as? String {
                country = temp
            }
        }
    
        if let temp = jsonDict["name"] as? String {
            city = temp
        }
        
        if let temp = jsonDict["id"] as? Int {
            cityid = temp
        }
        
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: self.managedObjectContext)
        location.setValue(lat, forKey: "lat")
        location.setValue(lon, forKey: "lon")
        location.setValue(country, forKey: "country")
        location.setValue(city, forKey: "cityName")
        location.setValue(cityid, forKey: "cityID")
        
        appDelegate.saveContext()
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = textFieldAddLocation.text {
           // getLocation(location: temp)

        }
    }
    
    @IBAction func buttonAddLocationPressed(_ sender: Any) {
        if let temp = textFieldAddLocation.text {
           getLocation(location: temp)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("removed keyboard")
        return false
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Search Error", message: "The API might be down or you entered an invalid location \n The correct format is city,state,country \n or \n city,country", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
