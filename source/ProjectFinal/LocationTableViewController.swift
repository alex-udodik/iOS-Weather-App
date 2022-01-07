//
//  LocationTableViewController.swift
//  ProjectFinal
//
//  Created by Alex on 4/19/21.
//

import Foundation
import UIKit
import CoreData

class LocationTableViewController: UITableViewController {
    
    var locationsList: [NSManagedObject] = []
    var index = 0
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LocationTableViewController initiated")
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        locationsList = fetchLocations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationsList = fetchLocations()
        tableView.reloadData()
     }
    
    func fetchLocations() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        var locations: [NSManagedObject] = []
        do {
            locations = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("get location error: \(error)")
        }
        return locations
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locationsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)

        let location = locationsList[indexPath.row]
        let city = location.value(forKey: "cityName") as? String
        let country = location.value(forKey: "country") as? String
        
        var temp = ""
        
        if let citytemp = city {
            temp += citytemp
        }
        
        if let countrytemp = country {
            temp += ", "
            temp += countrytemp
        }
        
        cell.textLabel?.text = temp
        //cell.detailTextLabel?.text = "77° C"
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToTabController") { // Check for correct segue
            let tabVC = segue.destination as! TabController
            let mycell = sender as! UITableViewCell
            
            let indexPath = tableView.indexPath(for: mycell)
            if let temp = indexPath?.row {
                let location = locationsList[temp]
                let cityid = location.value(forKey: "cityID") as? Int
                let cityname = location.value(forKey: "cityName") as? String
                let country = location.value(forKey: "country") as? String
                
                tabVC.cityid = cityid
                tabVC.cityName = cityname
                tabVC.country = country
            }
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = locationsList[indexPath.row]
            deleteLocation(location)
            locationsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteLocation(_ location: NSManagedObject) {
        managedObjectContext.delete(location)
        appDelegate.saveContext()
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
    }
    
    @IBAction func unwindToViewControllerNameHere(segue: UIStoryboardSegue) {
        
        if (segue.identifier == "unwindFromAddLocationToLocationTableView") {
            
            //locationsList = fetchLocations()
            //tableView.reloadData()
            
        }
        else {
            print("none")
        }
    }
}
