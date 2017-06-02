//
//  RadioButton.swift
//  SaloonVendor
//
//  Created by Pratyush Pratik on 17/05/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import UIKit

class RadioButton: UIButton {
    
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.black.cgColor
            } else {
                self.layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
}
//override func awakeFromNib() {
//    self.view.layoutIfNeeded()
//
//    womanRadioButton.selected = true
//    manRadioButton.selected = false
//}
//
//override func viewDidLoad() {
//    womanRadioButton?.alternateButton = [manRadioButton!]
//    manRadioButton?.alternateButton = [womanRadioButton!]
//}
