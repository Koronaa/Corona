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
            return self.black
        }else{
            return self.white
        }
    }
}
