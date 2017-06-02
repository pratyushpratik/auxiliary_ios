//
//  CheckBox.swift
//  SaloonVendor
//
//  Created by Pratyush Pratik on 17/05/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    
    // Images
    let checkedImage = /UIImage(named: Asset.icCheckBox.rawValue)
    let uncheckedImage = /UIImage(named: Asset.icCheckBoxOutlineBlank.rawValue)
    
    // Bool property
    @IBInspectable var isChecked: Bool = false {
        didSet{
            isChecked == true ? self.setImage(checkedImage, for: .normal) : self.setImage(uncheckedImage, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
