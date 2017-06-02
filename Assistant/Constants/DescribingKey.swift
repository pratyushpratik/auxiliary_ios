//
//  DescribingKey.swift
//  SaloonVendor
//
//  Created by Pratyush Pratik on 25/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import Foundation

//MARK: - Describing Key
enum DescribingKey : String {
    
    /****************** View cell nib name *******************/
    case editServicesVC = "EditServicesViewController"
    case datePicker = "DatePickerView"
    case addOffer = "AddOffer"
    case addService = "AddService"
    case filterCategoryView = "FilterCategoryView"
    
    /***************** table view cell nib name *****************/
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
    
    /******************** collection view cell nib name ****************/
    case requestsDayDateCVCell = "RequestsDayDateCollectionViewCell"
    case profileHeaderCVCell = "ProfileHeaderCollectionViewCell"
    
    var rV:String{
        return self.rawValue
    }
}
