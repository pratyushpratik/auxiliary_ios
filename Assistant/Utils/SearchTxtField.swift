//
//  SearchTextField.swift
//  SaloonVendor
//
//  Created by Pratyush Pratik on 29/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import SearchTextField

extension SearchTextField {
    
    //static let shared = SearchTxtField()
    
    /********************* start visible ******************************/
    func elementsShouldVisible(bool: Bool) {
        self.startVisible = bool
    }
    
    /******************* Elements in textField *************************/
    func elementsInTxtField(arr: [String]) {
        self.filterStrings(arr)
    }
    
    func showSubtitleImage(arr: [String],title: String, subtitle: String, imageName: String){
        for _ in arr {
            _ = SearchTextFieldItem(title: title, subtitle: subtitle, image: UIImage(named: imageName))
        }
    }
    
    /*********************** Customized frame ****************************/
    func customizeFrame(cgRect: CGRect){
        _ = SearchTextField(frame: cgRect)
    }
    
    /*********************** customiseFont ************************/
    func customiseFont(font: UIFont){
        self.theme.font = font
    }
    
    /*********************** customiseBGColor ************************/
    func customiseBGColor(bgColor: UIColor){
        self.theme.bgColor = bgColor
    }
    
    /*********************** customiseBorderColor ************************/
    func customiseBorderColor(borderColor: UIColor){
        self.theme.borderColor = borderColor
    }
    
    /*********************** customiseTheme separatorColor ************************/
    func customiseTheme(placeholderColor: UIColor){
        self.theme.placeholderColor = placeholderColor
    }
    
    /*********************** Modify current theme properties ************************/
    func customiseTheme(separatorColor: UIColor){
        self.theme.separatorColor = separatorColor
    }
    
    /*********************** customiseTheme ************************/
    func customiseTheme(cellHeight: CGFloat) {
        self.theme.cellHeight = cellHeight
    }
    
    /*********************** Set specific comparision options - Default: .caseInsensitive ****************************/
    func customiseComparisionOptions(){
        self.comparisonOptions = [.caseInsensitive]
    }
    
    /************************ Set the max number of results. By default it's not limited *****************************/
    func maxResultCount(count: Int){
        self.maxNumberOfResults = count
    }
    
    /********************* You can also limit the max height of the results list *****************/
    func maxResultsListHeight(listHeight: Int){
        self.maxResultsListHeight = listHeight
    }
    
    /***************************** Customize the way it highlights the search string. By default it bolds the string ****************************/
    func customiseHighlights(nsbgColor: UIColor,nsFont: UIFont){
        self.highlightAttributes = [NSBackgroundColorAttributeName: nsbgColor, NSFontAttributeName: nsFont]
    }
    
    /********************* Handle what happens when the user picks an item. By default the title is set to the text field ***********************/
    func userPickingItemHandler(){
        self.itemSelectionHandler = {item, itemPosition in
            self.text = item.title
        }
    }
    
    /**
     * Update data source when the user stops typing.
     * It's useful when you want to retrieve results from a remote server while typing
     * (but only when the user stops doing it)
     **/
    //    func dataSourceUpdation(txtField: SearchTextField) {
    //        var stf = SearchTextField()
    //        txtField.userStoppedTypingHandler = {
    //            if let criteria = txtField.text {
    //                if criteria.characters.count > 1 {
    //
    //                    // Show the loading indicator
    //                    txtField.showLoadingIndicator()
    //
    //                    searchm(criteria) { results in
    //                        // Set new items to filter
    //                        self.acronymTextField.filterItems(results)
    //
    //                        // Hide loading indicator
    //                        self.txtField.stopLoadingIndicator()
    //                    }
    //                }
    //            }
    //        }
    //    }
}
