//
//  GraphController.swift
//  ProjectFinal
//
//  Created by Alex on 4/19/21.
//

import Foundation
import UIKit
import Charts
import TinyConstraints
import CoreData

class GraphController: UIViewController, ChartViewDelegate{

    var lineChartView: LineChartView!
    var list: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GraphController")
        
        lineChartView = LineChartView()
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        lineChartView.backgroundColor = .systemOrange
        
        lineChartView.rightAxis.enabled = false
        
        let yAxis = lineChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.xAxis.labelTextColor = .white
        lineChartView.xAxis.axisLineColor = .systemGray6
        lineChartView.xAxis.labelCount = 3
        lineChartView.animate(xAxisDuration: 1.5)
        
        createData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func createData() {
        if list.count > 0 {
            
            var dataset : [ChartDataEntry] = []
            
            for obj in list {
                if let date = obj.value(forKey: "date") as? String {
                    var nodash = date.replacingOccurrences(of: "-", with: "")
                    var nocolon = nodash.replacingOccurrences(of: ":", with: "")
                    var nospace = nocolon.replacingOccurrences(of: " ", with: ".")
                    
                    var xdate = Double(nospace)
                    if let temp = obj.value(forKey: "temperature") as? String {
                        var atemp = temp.replacingOccurrences(of: "Temperature: ", with: "")
                        var antemp = atemp.replacingOccurrences(of: "° C", with: "")

                        if let ktemp = Double(antemp) {
                            //var farenheit = convertKelvinToFarenheit(temperature: ktemp)
                            
                            var x: Double = 0.0
                            if let temp = xdate {
                                x = temp
                            }
                            var chartdata = ChartDataEntry(x: x, y: Double(ktemp))
                            dataset.append(chartdata)
                        }
                    }
                }
            }
            
            setData(values: dataset)
        }
    }
    
    func setData(values: [ChartDataEntry]) {
        let set = LineChartDataSet(entries: values, label: "Temperature (C) on Days (YYYY-MM-DD.HH)")
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.white)
        set.fill = Fill(color: .white)
        set.fillAlpha = 0.8
        set.drawFilledEnabled = true
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightColor = .systemRed
        
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    func convertKelvinToFarenheit(temperature: Double) -> Int{
        var temp = Int((Double(temperature) * (9/5)) - 459.67)
        return temp
    }
}
