//
//  ForecastController.swift
//  ProjectFinal
//
//  Created by Alex on 4/19/21.
//

import Foundation
import UIKit
import CoreData

class ForecastController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var labelDayWeatherForecast: UILabel!
    
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelConditions: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelVisibility: UILabel!
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    var cityID: Int!
    var cityName: String!
    var country: String!
    let reuseIdentifier = "collectionCell"
    
    var numOfDates : Int = 0
    var items : [String] = []
    var uiimages: [UIImage] = []
    var uiimageindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ForecastController")
        
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        myCollectionView.delegate = self
        getLocation()
        get5DayForecast()
        
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        
        uiimageindex = 0

        
        if sender.isOn {
            var temp = labelTemperature.text
            var noword = temp?.replacingOccurrences(of: "Temperature: ", with: "")
            var nounit = noword?.replacingOccurrences(of: "° F", with: "")
            
            if let tempnum = Double(nounit!) as? Double {
                var convertedtemp = Double(Double(tempnum - 32) / 1.8)
                var finaltemp = Int(convertedtemp)
                
                labelTemperature.text = "Temperature: \(finaltemp)° C"
                
                var windspeed = labelWindSpeed.text
                var windnoword = windspeed?.replacingOccurrences(of: "Wind Speed: ", with: "")
                var windnolabel = windnoword?.replacingOccurrences(of: " mph", with: "")
                
                if let windnumber = Double(windnolabel!) as? Double {
                    var actual = (windnumber / 2.237)
                    var convertedwindspeed = Int(actual)
                    
                    labelWindSpeed.text = "Wind Speed: \(convertedwindspeed) m/s"
                }
                
                var visibility = labelVisibility.text
                var visibilitynoword = visibility?.replacingOccurrences(of: "Visibility: ", with: "")
                var visibilitynolabel = visibilitynoword?.replacingOccurrences(of: " miles", with: "")
                
                if let visibilitynum = Double(visibilitynolabel!) as? Double {
                    var miles = visibilitynum * 1609
                    
                    var milesactual = Int(miles)
                    labelVisibility.text = "Visibility: \(milesactual) m"
                }
                if uiimages.count == 4 {
                   // 8 9 10 11
                    var tempmaxes : [String] = []
                    var tempmins : [String] = []
                    
                    var tempminfinals : [String] = []
                    var tempmaxfinals : [String] = []
                    
                    tempmins.append(items[8])
                    tempmins.append(items[9])
                    tempmins.append(items[10])
                    tempmins.append(items[11])
                    
                    tempmaxes.append(items[12])
                    tempmaxes.append(items[13])
                    tempmaxes.append(items[14])
                    tempmaxes.append(items[15])

                    for item in tempmins {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° F", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum - 32) / 1.8)
                            var finaltemp = Int(convertedtemp)
                            
                            tempminfinals.append("\(finaltemp)° C")
                        }
                    }
                    
                    items[8] = tempminfinals[0]
                    items[9] = tempminfinals[1]
                    items[10] = tempminfinals[2]
                    items[11] = tempminfinals[3]
                    
                    for item in tempmaxes {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° F", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum - 32 ) / 1.8)
                            var finaltemp = Int(convertedtemp)
                            
                            tempmaxfinals.append("\(finaltemp)° C")
                        }
                    }
                    
                    items[12] = tempmaxfinals[0]
                    items[13] = tempmaxfinals[1]
                    items[14] = tempmaxfinals[2]
                    items[15] = tempmaxfinals[3]


                    self.myCollectionView.reloadData()
                }
                else if (uiimages.count == 5) {
                   // 10 11 12 13 14
                    var tempmaxes : [String] = []
                    var tempmins : [String] = []
                    
                    var tempminfinals : [String] = []
                    var tempmaxfinals : [String] = []
                    
                    tempmins.append(items[10])
                    tempmins.append(items[11])
                    tempmins.append(items[12])
                    tempmins.append(items[13])
                    tempmins.append(items[14])
                    
                    tempmaxes.append(items[15])
                    tempmaxes.append(items[16])
                    tempmaxes.append(items[17])
                    tempmaxes.append(items[18])
                    tempmaxes.append(items[19])

                    for item in tempmins {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° F", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum - 32) / 1.8)
                            var finaltemp = Int(convertedtemp)
                            
                            tempminfinals.append("\(finaltemp)° C")
                        }
                    }
                    
                    items[10] = tempminfinals[0]
                    items[11] = tempminfinals[1]
                    items[12] = tempminfinals[2]
                    items[13] = tempminfinals[3]
                    items[14] = tempminfinals[4]
                    
                    for item in tempmaxes {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° F", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum - 32) / 1.8)
                            var finaltemp = Int(convertedtemp)
                            
                            tempmaxfinals.append("\(finaltemp)° C")
                        }
                    }
                    
                    items[15] = tempmaxfinals[0]
                    items[16] = tempmaxfinals[1]
                    items[17] = tempmaxfinals[2]
                    items[18] = tempmaxfinals[3]
                    items[19] = tempmaxfinals[4]


                    self.myCollectionView.reloadData()
                }
                
            }}
        else {
            var temp = labelTemperature.text
            var noword = temp?.replacingOccurrences(of: "Temperature: ", with: "")
            var nounit = noword?.replacingOccurrences(of: "° C", with: "")
            
            if let tempnum = Double(nounit!) as? Double {
                var convertedtemp = Double(Double(tempnum * 1.8) + 32)
                var finaltemp = Int(convertedtemp)
                
                labelTemperature.text = "Temperature: \(finaltemp)° F"
                
                var windspeed = labelWindSpeed.text
                var windnoword = windspeed?.replacingOccurrences(of: "Wind Speed: ", with: "")
                var windnolabel = windnoword?.replacingOccurrences(of: " m/s", with: "")
                
                if let windnumber = Double(windnolabel!) as? Double {
                    var actual = (windnumber * 2.2369362920519) 
                    var convertedwindspeed = Int(actual)
                    
                    labelWindSpeed.text = "Wind Speed: \(convertedwindspeed) mph"
                }
                
                var visibility = labelVisibility.text
                var visibilitynoword = visibility?.replacingOccurrences(of: "Visibility: ", with: "")
                var visibilitynolabel = visibilitynoword?.replacingOccurrences(of: " m", with: "")
                
                if let visibilitynum = Double(visibilitynolabel!) as? Double {
                    var miles = visibilitynum / 1609
                    
                    var milesactual = Int(miles)
                    labelVisibility.text = "Visibility: \(milesactual) miles"
                }
                
                if uiimages.count == 4 {
                   // 8 9 10 11
                    var tempmaxes : [String] = []
                    var tempmins : [String] = []
                    
                    var tempminfinals : [String] = []
                    var tempmaxfinals : [String] = []
                    
                    tempmins.append(items[8])
                    tempmins.append(items[9])
                    tempmins.append(items[10])
                    tempmins.append(items[11])
                    
                    tempmaxes.append(items[12])
                    tempmaxes.append(items[13])
                    tempmaxes.append(items[14])
                    tempmaxes.append(items[15])

                    for item in tempmins {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° C", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum * 1.8) + 32)
                            var finaltemp = Int(convertedtemp)
                            
                            tempminfinals.append("\(finaltemp)° F")
                        }
                    }
                    
                    items[8] = tempminfinals[0]
                    items[9] = tempminfinals[1]
                    items[10] = tempminfinals[2]
                    items[11] = tempminfinals[3]
                    
                    for item in tempmaxes {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° C", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum * 1.8) + 32)
                            var finaltemp = Int(convertedtemp)
                            
                            tempmaxfinals.append("\(finaltemp)° F")
                        }
                    }
                    
                    items[12] = tempmaxfinals[0]
                    items[13] = tempmaxfinals[1]
                    items[14] = tempmaxfinals[2]
                    items[15] = tempmaxfinals[3]


                    self.myCollectionView.reloadData()
                }
                else if (uiimages.count == 5) {
                   // 10 11 12 13 14
                    var tempmaxes : [String] = []
                    var tempmins : [String] = []
                    
                    var tempminfinals : [String] = []
                    var tempmaxfinals : [String] = []
                    
                    tempmins.append(items[10])
                    tempmins.append(items[11])
                    tempmins.append(items[12])
                    tempmins.append(items[13])
                    tempmins.append(items[14])
                    
                    tempmaxes.append(items[15])
                    tempmaxes.append(items[16])
                    tempmaxes.append(items[17])
                    tempmaxes.append(items[18])
                    tempmaxes.append(items[19])

                    for item in tempmins {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° C", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum * 1.8) + 32)
                            var finaltemp = Int(convertedtemp)
                            
                            tempminfinals.append("\(finaltemp)° F")
                        }
                    }
                    
                    items[10] = tempminfinals[0]
                    items[11] = tempminfinals[1]
                    items[12] = tempminfinals[2]
                    items[13] = tempminfinals[3]
                    items[14] = tempminfinals[4]
                    
                    for item in tempmaxes {
                        var temp = item
                        var noword = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var nounit = noword.replacingOccurrences(of: "° C", with: "")
                        
                        if let tempnum = Double(nounit) as? Double {
                            var convertedtemp = Double(Double(tempnum * 1.8) + 32)
                            var finaltemp = Int(convertedtemp)
                            
                            tempmaxfinals.append("\(finaltemp)° F")
                        }
                    }
                    
                    items[15] = tempmaxfinals[0]
                    items[16] = tempmaxfinals[1]
                    items[17] = tempmaxfinals[2]
                    items[18] = tempmaxfinals[3]
                    items[19] = tempmaxfinals[4]


                    self.myCollectionView.reloadData()
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        
        if (numOfDates == 4) {
            var columnCount = 5
            let width  = (Int(self.myCollectionView.frame.width) - 10) / columnCount
            
            labelDayWeatherForecast.text = "4-Day Weather Forecast"
            return CGSize(width: width, height: width)
        }
        else if (numOfDates == 5) {
            var columnCount = 6
            let width  = (Int(self.myCollectionView.frame.width) - 5) / columnCount
            labelDayWeatherForecast.text = "5-Day Weather Forecast"
            return CGSize(width: width, height: width)
        }
        
        var columnCount = 6
        let width  = (Int(self.myCollectionView.frame.width) - 5) / columnCount
        return CGSize(width: width, height: width)
        
    }
    
    func getLocation() {
        
        if let location = cityID {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?id=" + String(location) + "&appid=87a2f4bbfb5d44364ab455c8a3aa1300"
            
            let url = URL(string: urlString)
            let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: handleResponse)
            dataTask.resume()
        }
        
    }
    
    func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        
        if let err = error {
            print("error: \(err.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("error: improperly-formatted response")
            return
        }
        
        let statusCode = httpResponse.statusCode
        
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            return
        }
        
        guard  let somedata = data else {
            print("error: no data")
            return
        }
        
        guard let dataStr = String(data: somedata, encoding: .utf8) else {
            print("error: improperly-formatted data")
            return
        }
        
        //print("success: response \(dataStr)")
        
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata),
              let jsonDict = jsonObj as? [String: Any],
              let weather = jsonDict["weather"] as? [[String: Any]]
        else {
            print("error: invalid JSON data")
            return
        }
        
        var description = "default"
        var humidityPercent = 0
        var temperatureKelvin: Double = 0.0
        var windSpeedMetersPerSec: Double = 0.0
        var visibilityMeters: Int = 0
        var codeid = ""
        
        if let temp = weather[0] as? [String: Any] {
            if let tempmain = temp["main"] as? String {
                description = tempmain
            }
            if let tempid = temp["icon"] as? String {
                codeid = tempid
            }
        }
        
        
        if let temp = jsonDict["main"] as? [String: Any] {
            if let temphumdity = temp["humidty"] as? Int {
                humidityPercent = temphumdity
            }
            if let tempKelvin = temp["temp"] as? Double {
                temperatureKelvin = tempKelvin
            }
        }
        
        if let temp = jsonDict["wind"] as? [String: Any] {
            if let tempspeed = temp["speed"] as? Double {
                windSpeedMetersPerSec = tempspeed
            }
        }
        
        if let temp = jsonDict["visibility"] as? Int {
            visibilityMeters = temp
        }
        
        var builder = ""
        
        if let temp = cityName {
            builder += temp
        }
        
        if let temp = country {
            builder += ", "
            builder += temp
        }
        
        let iconUrl = "http://openweathermap.org/img/wn/\(codeid)@4x.png"
        
        var tempC : Int = convertToCelsius(temperatureKelvin: temperatureKelvin)
        DispatchQueue.main.async {
            
            
            self.setLabels(location: builder, description: description, temperature: tempC, humidity: humidityPercent, windSpeed: windSpeedMetersPerSec, visibility: visibilityMeters)
            
            self.loadWeatherImage(String(iconUrl))
        }
        
        
    }
    func get5DayForecast() {
        if let location = cityID {
            let urlString = "https://api.openweathermap.org/data/2.5/forecast?id=" + String(location) + "&appid=87a2f4bbfb5d44364ab455c8a3aa1300"
            
            let url = URL(string: urlString)
            let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: handleForecastResponse(data:response:error:))
            dataTask.resume()
        }
    }
    
    func handleForecastResponse(data: Data?, response: URLResponse?, error: Error?) {
        
        if let err = error {
            print("error: \(err.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("error: improperly-formatted response")
            return
        }
        
        let statusCode = httpResponse.statusCode
        
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            return
        }
        
        guard  let somedata = data else {
            print("error: no data")
            return
        }
        
        guard let dataStr = String(data: somedata, encoding: .utf8) else {
            print("error: improperly-formatted data")
            return
        }
        
        //print("success: response \(dataStr)")
        
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata),
              let jsonDict = jsonObj as? [String: Any],
              let list = jsonDict["list"] as? [[String: Any]]
        else {
            print("error: invalid JSON data")
            return
        }
        
        var index = 0
        var temperatures: [Double] = []
        var dates: [String] = []
        var images: [String] = []
        
        var max = -99999.0
        var min = 99999.0
        var firstDate = ""
        
        if let tempobj = list[0] as? [String: Any] {
            if let tempdate = tempobj["dt_txt"] as? String {
                firstDate = String(tempdate.prefix(10))
            }
        }
        
        //find the max temp. We are doing this because we have to pay for the 15-day forecast api call
        while(index != list.count) {
            
            if let tempdate = list[index]["dt_txt"] as? String {
                var convertedDate = String(tempdate.prefix(10))
                
                if let mainobj = list[index]["main"] as? [String: Any] {
                    if let temperatureK = mainobj["temp"] as? Double {
                        temperatures.append(temperatureK)
                        dates.append(convertedDate)
                    }
                    
                    if let tempweather = list[index]["weather"] as? [[String: Any]] {
                        if let temp = tempweather[0] as? [String: Any] {
                            if let tempid = temp["icon"] as? String {
                                let codeid = tempid
                                let iconUrl = "http://openweathermap.org/img/wn/\(codeid)@4x.png"
                                images.append(iconUrl)
                            }
                        }
                    }
                }
            }
            
            index = index + 1
        }
        
        var date = dates[0]
        var temp = temperatures[0]
        
        index = 0
        
        var distinctDates : [String] = []
        distinctDates.append(date)
        var temps : [[Double]] = []
        var singleTemp : [Double] = []
        var newimages : [String] = []
        
        while(index != dates.count) {
            singleTemp.append(temperatures[index])
            
            if (date != dates[index]) {
                date = dates[index]
                temps.append(singleTemp)
                singleTemp = []
                distinctDates.append(date)
                newimages.append(images[index])
            }
            index = index + 1
        }
        
        
        var maxList : [Double] = []
        var minList : [Double] = []
        var counter = 0
        
        for temperatureList in temps {
            var smallestTemp : Double =  temperatureList[counter]
            
            for singleTemperature in temperatureList {
                if (singleTemperature < smallestTemp) {
                    smallestTemp = singleTemperature
                }
            }
            minList.append(smallestTemp)
            counter = counter + 1
        }
        
        counter = 0
        for temperatureList in temps {
            var biggestTemp : Double =  temperatureList[counter]
            
            for singleTemperature in temperatureList {
                if (singleTemperature > biggestTemp) {
                    biggestTemp = singleTemperature
                }
            }
            maxList.append(biggestTemp)
            counter = counter + 1
        }
        
        if (distinctDates.count != minList.count) {
            if (distinctDates.count > minList.count) {
                distinctDates.remove(at: distinctDates.count - 1)
            }
            else {
                minList.remove(at: minList.count - 1)
                maxList.remove(at: maxList.count - 1)
                images.remove(at: images.count - 1)
            }
        }
        
        var forecastDates : [String] = []
        var minTemps : [Int] = []
        var maxTemps : [Int] = []
        
        
        index = 0
        while (index != minList.count) {
            var converted = convertToCelsius(temperatureKelvin: minList[index])
            minTemps.append(converted)
            
            converted = convertToCelsius(temperatureKelvin: maxList[index])
            maxTemps.append(converted)
            forecastDates.append(distinctDates[index])
            index = index + 1
        }
        
        index = 0
        
        numOfDates = forecastDates.count
        
        for date in forecastDates {
            let index = date.index(date.endIndex, offsetBy: -5)
            let mySubstring = date.suffix(from: index) // playground
            items.append(String(mySubstring))
        }
        
        index = index + minTemps.count
        
        
        
        
        DispatchQueue.main.async {
            
            for image in newimages {
                self.items.append(image)
                self.loadForecastImage(String(image))
            }
            
            for low in minTemps {
                self.items.append("\(String(low))° C")
            }
            
            for high in maxTemps {
                self.items.append("\(String(high))° C")
            }
            
            self.myCollectionView.reloadData()
        }
    }
    
    func convertToFarenheit(temperatureKelvin: Double) -> Int{
        var temp = Int((temperatureKelvin * (9/5)) - 459.67)
        return temp
    }
    
    func convertToCelsius(temperatureKelvin: Double) -> Int {
        var temp = Int(temperatureKelvin - 273.15)
        return temp
    }
    
    func convertToKelvinFromC() {
        
    }
    
    func convertToKelvinFromF() {
        
    }
    
    func setLabels(location: String, description: String, temperature: Int, humidity: Int, windSpeed: Double, visibility: Int) {
        
        labelLocation.text = location
        labelConditions.text = "Conditions: \(description)"
        labelTemperature.text = "Temperature: \(temperature)° C"
        labelWindSpeed.text = "Wind Speed: \(windSpeed) m/s"
        labelHumidity.text = "Humidity: \(humidity)%"
        labelVisibility.text = "Visibility: \(visibility) m"
    }
    
    func loadWeatherImage(_ urlString: String) {
        // URL comes from API response; definitely needs some safety checks
        if let urlStr = urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStr) {
                let dataTask = URLSession.shared.dataTask(with: url,
                                                          completionHandler: {(data, response, error) -> Void in
                                                            if let imageData = data {
                                                                let image = UIImage(data: imageData)
                                                                
                                                                DispatchQueue.main.async {
                                                                    self.imageWeatherIcon.image = image
                                                                }
                                                            }
                                                          })
                dataTask.resume()
            }
        }
    }
    
    func loadForecastImage(_ urlString: String) {
        // URL comes from API response; definitely needs some safety checks
        if let urlStr = urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStr) {
                let dataTask = URLSession.shared.dataTask(with: url,
                                                          completionHandler: {(data, response, error) -> Void in
                                                            if let imageData = data {
                                                                if let image = UIImage(data: imageData) {
                                                                    self.uiimages.append(image)
                                                                }
                                                                
                                                            }
                                                          })
                dataTask.resume()
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionCell
        if (self.items[indexPath.row].contains("http")) {
            if (self.uiimages.count > 0) {
                if uiimageindex < uiimages.count {
                    let image = uiimages[uiimageindex]
                    cell.myimage.image = image
                    cell.mylabel.text = ""
                    //uiimageindex = uiimageindex + 1
                }
                else {
                    cell.mylabel.text = "err pic"
                }
                
            }
            
            
        }
        else {
            cell.myimage.image = nil
            cell.mylabel.text = self.items[indexPath.row]
            
        }
        
        return cell
    }
    
    func saveToHistory() {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        
        var conditions = labelConditions.text
        var humdity = labelHumidity.text
        var temperature = labelTemperature.text
        var visibility = labelVisibility.text
        var windspeed = labelWindSpeed.text
        
        let saveable = NSEntityDescription.insertNewObject(forEntityName: "Saveable", into: self.managedObjectContext)
        saveable.setValue(conditions, forKey: "conditions")
        saveable.setValue(dateString, forKey: "date")
        saveable.setValue(humdity, forKey: "humidity")
        saveable.setValue(temperature, forKey: "temperature")
        saveable.setValue(visibility, forKey: "visibility")
        saveable.setValue(windspeed, forKey: "windspeed")
        saveable.setValue(cityID, forKey: "cityID")
        saveable.setValue(country, forKey: "country")
        saveable.setValue(cityName, forKey: "city")
        appDelegate.saveContext()
        
        print("saved to coredata")
    }
    
    
}
