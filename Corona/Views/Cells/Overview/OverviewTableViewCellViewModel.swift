//
//  OverviewTableViewCellViewModel.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

protocol OverviewViewModel {
    var newDeathCount:Int {get}
    var newCasesCount:Int {get}
    var reportedCasesCount:String {get}
    var recoveredCount:String {get}
    var deathCount:Int {get}
}

class OverviewTableViewCellViewModelIMPL:OverviewViewModel{
    
    var statistics:Statistics!
    
    var newDeathCount:Int {return statistics.newDeathCount}
    var newCasesCount:Int {return statistics.newCasesCount}
    var reportedCasesCount:String {return statistics.reportedCasesCount.delimiter}
    var recoveredCount:String {return statistics.recoveredCount.delimiter}
    var deathCount:Int {return statistics.deathCount}
    var activeCasesCount:Int {return statistics.activeCasesCount}
    
    init(statistics:Statistics) {
        self.statistics = statistics
    }
}
