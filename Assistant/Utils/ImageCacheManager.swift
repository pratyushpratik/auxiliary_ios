//
//  ImageCacheManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ImageCacheManager {
    
    static let shared : ImageCacheManager = {
        let instance = ImageCacheManager()
        return instance
    }()
    
    func download(imageFrom imageURL:String ,imageView : UIImageView, placHolderimage : UIImage? = nil)  {
        
        guard let url = URL(string: imageURL) else { return }
        imageView.kf.setImage(with: url, placeholder : placHolderimage, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
}
