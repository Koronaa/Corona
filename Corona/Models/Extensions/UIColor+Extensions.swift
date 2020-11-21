//
//  UIColor+Extensions.swift
//  Corona
//
//  Created by Sajith Konara on 2020-11-20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

extension UIColor{
    
    static var adaptiveWhite:UIColor{
        if HomeViewModelIMPL.isDarkModeON{
            return self.customBlack
        }else{
            return self.white
        }
    }
    
    static var customBlack:UIColor{
        UIColor(red: 33/256, green: 33/256, blue: 33/256, alpha: 1)
    }
}
