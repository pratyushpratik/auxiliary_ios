//
//  ArithmaticManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation
import UIKit

class ArithmaticManager {
    
    static let shared : ArithmaticManager = {
        let instance = ArithmaticManager()
        return instance
    }()
    
    func roundDouble(value : Double,numberOfPlaces : Int) -> Double {
        
        let numberOfPlaces = Double(numberOfPlaces)
        let multiplier = pow(10.0, numberOfPlaces)
        let rounded = round(value * multiplier) / multiplier
        return rounded
    }
}
