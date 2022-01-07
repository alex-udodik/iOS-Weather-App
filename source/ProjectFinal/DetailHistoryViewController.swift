//
//  DetailHistoryViewController.swift
//  ProjectFinal
//
//  Created by Alex on 4/25/21.
//

import Foundation
import UIKit

class DetailHistoryViewController: UIViewController {
    
    @IBOutlet weak var labelHistoryForecastFor: UILabel!
    @IBOutlet weak var labelOnDate: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelConditions: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelVisibility: UILabel!
    
    var date: String!
    var location: String!
    var humidity: String!
    var visibility: String!
    var windspeed: String!
    var conditions: String!
    var temperature: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setLabels()
    }
    
    func setLabels() {
        if let temp = location {
            labelHistoryForecastFor.text = "History Forecast For: \(temp)"
        }
        
        if let temp = date {
            labelOnDate.text = "On: \(temp)"
        }
        
        if let temp = temperature {
            //labelTemperature.text = ""
            
            
                
            labelTemperature.text = temp
            
        }
        
        if let temp = conditions {
            labelConditions.text = ""
            labelConditions.text = "\(temp)"
        }
        
        if let temp = windspeed {
            labelWindSpeed.text = ""
            labelWindSpeed.text = "\(temp)"
        }
        
        if let temp = humidity {
            labelHumidity.text = ""
            labelHumidity.text = "\(temp)"
        }
        
        if let temp = visibility {
            labelVisibility.text = ""
            labelVisibility.text = "\(temp)"
        }
    }
    
    
}
