//
//  HistoryController.swift
//  ProjectFinal
//
//  Created by Alex on 4/19/21.
//

import Foundation
import UIKit
import CoreData

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource   {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var historyList: [NSManagedObject] = []
    var index = 0
    
    var cityid : Int?
    var cityidtofilter = 0
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HistoryController")
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        if let temp = cityid {
            cityidtofilter = temp
        }
        
        historyList = loadSaveables()
        
        
    }
    
    func loadSaveables() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Saveable")
        var locations: [NSManagedObject] = []
        do {
            locations = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("get location error: \(error)")
        }
        
        var filteredlocations : [NSManagedObject] = []
        
        for obj in locations {
            if let temp = obj.value(forKey: "cityID") as? Int {
                if (temp == cityidtofilter) {
                    filteredlocations.append(obj)
                }
            }
        }
        return filteredlocations
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "saveableCell", for: indexPath)
        
        let saveable = historyList[indexPath.row]
        
        
        var city = ""
        if let temp = saveable.value(forKey: "city") as? String {
            city = temp
        }
        
        var country = ""
        if let temp = saveable.value(forKey: "country") as? String {
            country = temp
        }
        
        var location = "\(city), \(country)"
        var date = saveable.value(forKey: "date") as? String
        
        cell.textLabel?.text = location
        cell.detailTextLabel?.text = date
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToDetailHistoryView") { // Check for correct segue
            let detailVC = segue.destination as! DetailHistoryViewController
            let mycell = sender as! UITableViewCell
            
            var cellindex : Int = 0
            if let temp = self.myTableView.indexPath(for: mycell)?.row as? Int {
                cellindex = temp
            }
            
            let obj = historyList[cellindex]
            
            var date = ""
            var location = ""
            var humidty = ""
            var visibility = ""
            var windspeed = ""
            var conditions = ""
            var temperature = ""
            
            if let temp = obj.value(forKey: "date") as? String {
                date = temp
            }
            
            if let temp = obj.value(forKey: "city") as? String {
                if let tempcountry = obj.value(forKey: "country") as? String {
                    location = "\(temp), \(tempcountry)"
                }
            }
            
            if let temp = obj.value(forKey: "humidity") as? String {
                humidty = temp
            }
            
            if let temp = obj.value(forKey: "visibility") as? String {
                visibility = temp
            }
            
            if let temp = obj.value(forKey: "windspeed") as? String {
                windspeed = temp
            }
            
            if let temp = obj.value(forKey: "conditions") as? String {
                conditions = temp
            }
            
            if let temp = obj.value(forKey: "temperature") as? String {
                temperature = temp
            }
            
            
            detailVC.date = date
            detailVC.location = location
            detailVC.humidity = humidty
            detailVC.visibility = visibility
            detailVC.windspeed = windspeed
            detailVC.conditions = conditions
            detailVC.temperature = String(temperature)
        }
    }
    
    func getHistoryList() -> [NSManagedObject]{
        return self.historyList
    }
}
