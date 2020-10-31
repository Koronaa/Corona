//
//  String+Extensions.swift
//  Corona
//
//  Created by Sajith Konara on 10/31/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

extension String{
    
    var formattedDate:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let modifiedDateString = dateFormatter.string(from: date)
        return modifiedDateString
    }
    
}
