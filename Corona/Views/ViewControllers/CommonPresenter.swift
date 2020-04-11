//
//  InitialPresenter.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxRelay

protocol CommonPresenter {
    func loadStatistics(onComplete: @escaping (_ stats:BehaviorRelay<(Statistics?,String?,Bool?)>)->Void)
}

class CommonPresenterIMPL:CommonPresenter{
    
    fileprivate let modelLayer:ModelLayerIMPL
    
    init(modelLayer:ModelLayerIMPL) {
        self.modelLayer = modelLayer
    }
    
    func loadStatistics(onComplete: @escaping (BehaviorRelay<(Statistics?, String?, Bool?)>) -> Void) {
        let statRelay = BehaviorRelay<(Statistics?, String?, Bool?)>(value: (nil,nil,nil))
        modelLayer.getStatData { (stat, errorMessage, isRetry) in
            statRelay.accept((stat,errorMessage,isRetry))
            onComplete(statRelay)
        }
    }
}
