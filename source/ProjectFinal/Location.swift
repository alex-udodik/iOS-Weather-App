//
//  Location.swift
//  ProjectFinal
//
//  Created by Alex on 4/20/21.
//

import Foundation

class Location {
    
    var lat: Float
    var long: Float
    var cityName: String
    var country: String
    var cityID: Int
    
    init(lat: Float, long: Float, cityName: String, country: String, cityID: Int) {
        
        self.lat = lat
        self.long = long
        self.cityName = cityName
        self.country = country
        self.cityID = cityID
    }
}
