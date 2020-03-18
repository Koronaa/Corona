//
//  URLConstants.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct URLConstants {
    
    struct Api {
        static let HOST = "http://hpb.health.gov.lk/api"
        
        struct Path {
            static var stat:String{
                return HOST + "/get-current-statistical"
            }
        }
    }
}
