//
//  HomePresenter.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class HomePresenter{
    var statistics:Statistics!
    
    var date:String {
        let date = statistics.updatedDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        return "Last updated on \(dateFormatter.string(from: date))"
    }
    
    var hospitalCount:Int {
        return statistics.hospitals.count
    }
    
    init(statistics:Statistics) {
        self.statistics = statistics
    }
    
}
