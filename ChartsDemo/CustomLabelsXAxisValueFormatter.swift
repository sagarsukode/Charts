//
//  CustomLabelsAxisValueFormatter.swift
//  TimeStamp
//
//  Created by Sagar on 23/03/18.
//  Copyright © 2018 Harshal Bajaj. All rights reserved.
//

import Foundation
import UIKit
import Charts

class CustomLabelsXAxisValueFormatter : NSObject, IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let count = self.labels.count
        
        guard let axis = axis, count > 0 else {
            
            return ""
        }
        
        let factor = axis.axisMaximum / Double(count)
        
        let index = Int((value / factor).rounded())
        
        if index >= 0 && index < count {
            
            return self.labels[index]
        }
        
        return ""
    }
}
