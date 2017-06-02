//
//  SaloonVendor
//
//  Created by Pratyush Pratik on 31/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import GoogleMapsCore
import GooglePlacePicker

//MARK:- CLASS
class CommonMethod{
    
    static let shared = CommonMethod()
    
    //MARK:- PROPERTIES
    fileprivate var catNames = [String]()
    fileprivate var subCatNames = [String]()
    
    /*********************** Fetching Category Name ************************/
    @discardableResult func categoryNames() -> [String] {
        catNames.removeAll()
        if let category = sharedAppDelegate?.category {
            category.forEach({ (cat) in
                catNames.append(/cat.name)
            })
        }
        return catNames
    }
    
    /*********************** Fetching SubCategory Name ************************/
    @discardableResult func subCategoryNames() -> [String] {
        subCatNames.removeAll()
        if let category = sharedAppDelegate?.category {
            category.forEach({ (cat) in
                if let subCategory = cat.category_subs{
                    subCategory.forEach({ (subCat) in
                        subCatNames.append(/subCat.name)
                    })
                }
            })
        }
        return subCatNames
    }
    
    @discardableResult func constructDates(_count: Int) ->  (startUtcStr: String, endUtcStr: String) {
        
        let cal = Calendar.current
        var startComponents = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: DateTimeManager.shared.date(_value: _count)._date)
        startComponents.hour = 00
        startComponents.minute = 00
        startComponents.second = 00
        
        let startDate = /cal.date(from: startComponents)
        
        var endComponents = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: DateTimeManager.shared.date(_value: _count)._date)
        endComponents.hour = 23
        endComponents.minute = 59
        endComponents.second = 59
        
        let endDate = /cal.date(from: endComponents)
        
        let _startUtcStr = DateTimeManager.shared.toUTC(from: startDate)
        let _endUtcStr = DateTimeManager.shared.toUTC(from: endDate)
        return(_startUtcStr, _endUtcStr)
    }
}
