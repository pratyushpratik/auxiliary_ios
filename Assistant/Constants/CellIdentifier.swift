//
//  CellIdentifier.swift
//
//  Created by Pratyush Pratik on 30/03/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

//MARK:- MODULES
import Foundation

//MARK: - Cell Identifier
enum CellIdentifier : String {
    
    /**************** table view cell identifier ****************/
    case packagesTVCell = "PackagesTableViewCell"
    case bookingsTVCell = "BookingsTableViewCell"
    case requestsTVCell = "RequestsTableViewCell"
    case revenueRecurrenceTVCell = "RevenueRecurrenceTableViewCell"
    case profileTVCell = "ProfileTableViewCell"
    case myProfessionalsTVCell = "MyProfessionalsTableViewCell"
    case addProfessionalTVCell = "AddProfessionalTableViewCell"
    case bookingsItemsTVCell = "BookingsItemsTableViewCell"
    case requestItemsTVCell = "RequestItemsTableViewCell"
    case revenueRecurrenceItemsTVCell = "RevenueRecurrenceItemsTableViewCell"
    case reviewsTVCell = "ReviewsTableViewCell"
    case servicesTVCell = "ServicesTableViewCell"
    case servicesItemsTVCell = "ServicesItemsTableViewCell"
    case addOfferTVCell = "AddOfferTableViewCell"
    case filterCategoryCell = "FilterCategoryCell"
    
    /****************** collection view cell identifier ****************/
    case requestsDayDateCVCell = "RequestsDayDateCollectionViewCell"
    case profileHeaderCVCell = "ProfileHeaderCollectionViewCell"
    
    var rV:String{
        return self.rawValue
    }
}
