//
//  OverviewTableViewCellViewModel.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

protocol OverviewTableViewCellViewModel {
    var newDeathCount:Int {get}
    var newCasesCount:Int {get}
    var reportedCasesCount:String {get}
    var recoveredCount:String {get}
    var deathCount:Int {get}
}

class OverviewTableViewCellViewModelIMPL:OverviewTableViewCellViewModel{
    
    var statistics:Statistics!
    
    var newDeathCount:Int {return statistics.newDeathCount}
    var newCasesCount:Int {return statistics.newCasesCount}
    var reportedCasesCount:String {return statistics.reportedCasesCount.delimiter}
    var recoveredCount:String {return statistics.recoveredCount.delimiter}
    var deathCount:Int {return statistics.deathCount}
    
    init(statistics:Statistics) {
        self.statistics = statistics
    }
}
