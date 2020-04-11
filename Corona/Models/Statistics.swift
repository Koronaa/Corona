//
//  Statistics.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Statistics {
    var updatedDate:Date
    var reportedCasesCount:Int
    var deathCount:Int
    var recoveredCount:Int
    var newCasesCount:Int
    var newDeathCount:Int
    var activeCasesCount:Int
    var hospitals:[Hospital]

}
