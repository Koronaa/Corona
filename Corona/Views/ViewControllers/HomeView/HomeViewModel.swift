//
//  HomeViewModel.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxRelay

protocol HomeViewModel {
    
    func loadStatistics(onComplete: @escaping (_ stats:BehaviorRelay<(Statistics?,Error?,Bool?)>)->Void)
    var date:String {get}
    var hospitalCount:Int {get}
    var statistics:Statistics! {get}
    
}

class HomeViewModelIMPL:HomeViewModel{
    
    fileprivate let modelLayer:ModelLayerIMPL
    var statistics:Statistics!
    
    init(modelLayer:ModelLayerIMPL) {
        self.modelLayer = modelLayer
    }
    
    func loadStatistics(onComplete: @escaping (BehaviorRelay<(Statistics?, Error?, Bool?)>) -> Void) {
        let statRelay = BehaviorRelay<(Statistics?, Error?, Bool?)>(value: (nil,nil,nil))
        modelLayer.getStatData { (stat, errorMessage, isRetry) in
            statRelay.accept((stat,errorMessage,isRetry))
            onComplete(statRelay)
        }
    }
    
    var date:String {
        let dateString = statistics.updatedDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let modifiedDateString = dateFormatter.string(from: date)
        return "Last updated on \(modifiedDateString)"
    }
    
    var hospitalCount:Int {
        return statistics.hospitals.count
    }
    
}
