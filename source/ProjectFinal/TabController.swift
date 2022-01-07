//
//  ForecastTabController.swift
//  ProjectFinal
//
//  Created by Alex on 4/19/21.
//

import Foundation
import UIKit
import CoreData

class TabController : UITabBarController, UITabBarControllerDelegate{
    @IBOutlet var barButtonShowGraph: UIBarButtonItem!
    
    var cityid: Int?
    var cityName: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabController")
        self.delegate = self
        barButtonShowGraph.title = "Save Forecast"
        self.navigationItem.rightBarButtonItem = barButtonShowGraph
        
        
        var forecastVC = self.viewControllers![0] as! ForecastController
        if let temp = cityid {
            forecastVC.cityID = temp
        }
        if let temp = cityName {
            forecastVC.cityName = temp
        }
        if let temp = country {
            forecastVC.country = temp
        }
        
        var historyVC = self.viewControllers![1] as! HistoryController
        if let temp = cityid {
            historyVC.cityid = temp
        }

        
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let buttonName = tabBar.selectedItem?.title {
            
            if (buttonName == "Weather Forecast") {
                barButtonShowGraph.title = "Save Forecast"
                self.navigationItem.rightBarButtonItem = barButtonShowGraph
                

            }
            else if (buttonName == "Forecast History") {
                barButtonShowGraph.title = "Show Graph"
                self.navigationItem.rightBarButtonItem = barButtonShowGraph
            }
        }
        
        
    }

    
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    @IBAction func buttonRightBarButtonTapped(_ sender: UIBarButtonItem) {
        //print("test")
    }
    
        
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "segueToGraph" {
                if barButtonShowGraph.title != "Show Graph" {
                    
                    var controller = self.viewControllers![0] as! UIViewController
                    var fc = controller as! ForecastController
                    fc.saveToHistory()

                    return false
                }
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToGraph") { // Check for correct segue
            let graphVC = segue.destination as! GraphController
            
            var controller = self.viewControllers![1] as! UIViewController
            var hc = controller as! HistoryController
            var historylist = hc.getHistoryList()
            
            graphVC.list = historylist
            
        }
       
    }
    
    
    
}
