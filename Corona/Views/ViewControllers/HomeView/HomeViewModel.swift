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
    
    func loadStatistics()
    var date:String {get}
    var hospitalCount:Int {get}
    var statistics:BehaviorRelay<Statistics?> {get}
    var error:BehaviorRelay<Error?> {get}
    
}

class HomeViewModelIMPL:HomeViewModel{
    
    fileprivate let modelLayer:ModelLayerIMPL
    var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)
    var error: BehaviorRelay<Error?> = BehaviorRelay<Error?>(value: nil)
    
    
    init(modelLayer:ModelLayerIMPL) {
        self.modelLayer = modelLayer
    }
    
    func loadStatistics() {
        modelLayer.getStatData { (stat, error, _) in
            if stat != nil{
                self.statistics.accept(stat)
            }
            if error != nil{
                self.error.accept(error)
            }
        }
    }
    
    var date:String {
        let dateString = statistics.value?.updatedDate ?? DateFormatter().string(from: Date())
        return "Last updated on \(dateString.formattedDate)"
    }
    
    var hospitalCount:Int {
        return statistics.value?.hospitals.count ?? 0
    }
}
