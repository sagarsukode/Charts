//
//  ViewController.swift
//  ChartsDemo
//
//  Created by Sagar on 17/04/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController,ChartViewDelegate {
    
    @IBOutlet var barChartView: BarChartView!
    
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 50.0, 25.0, 57.0, 60.0, 28.0, 17.0, 47.0]
    let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0, 10.0, 15.0, 18.0, 25.0, 05.0, 10.0, 19.0]
    let xaxisValue: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    
    //MARK:- View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- ChartView Delegate -
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
//        print("\(entry.value) in \(xaxisValue[entry.x])")
    }
    
    //MARK:- General Methods -
    func setupView() {
        
        //legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        legend.textColor = UIColor.white
        
        // Y - Axis Setup
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.labelTextColor = UIColor.white
        yaxis.axisLineColor = UIColor.white
        
        barChartView.rightAxis.enabled = false
        
        // X - Axis Setup
        let xaxis = barChartView.xAxis
        let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
        formatter.labels = self.xaxisValue
        xaxis.valueFormatter = formatter
        
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.labelTextColor = UIColor.white
        xaxis.centerAxisLabelsEnabled = true
        xaxis.axisLineColor = UIColor.white
        xaxis.granularityEnabled = true
        xaxis.enabled = true
        
        
        barChartView.delegate = self
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.noDataTextColor = UIColor.white
        barChartView.chartDescription?.textColor = UIColor.clear
        
        setChart()
    }
    
    func setChart() {
        barChartView.noDataText = "Loading...!!"
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.xaxisValue.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.unitsSold[i]))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(self.unitsBought[i]))
            dataEntries1.append(dataEntry1)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Sold")
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "Bought")
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.5)]
        chartDataSet1.colors = [UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.8)]
        
        
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.4
        let barSpace = 0.03
        let barWidth = 0.2
        
        chartData.barWidth = barWidth
        
        barChartView.xAxis.axisMinimum = 0.0
        barChartView.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(self.xaxisValue.count)
        
        chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        
        barChartView.xAxis.granularity = barChartView.xAxis.axisMaximum / Double(self.xaxisValue.count)
        
        barChartView.data = chartData
        
        barChartView.notifyDataSetChanged()
        barChartView.setVisibleXRangeMaximum(4)
        barChartView.animate(yAxisDuration: 1.0, easingOption: .linear)
        chartData.setValueTextColor(UIColor.white)
    }
    
    
}

