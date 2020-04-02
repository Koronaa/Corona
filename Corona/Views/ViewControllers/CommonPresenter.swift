//
//  InitialPresenter.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class CommonPresenter{
    
    fileprivate let modelLayer:ModelLayer
    
    init(modelLayer:ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadStatistics(onComplete: @escaping (_ stats:Statistics?, _ error:String?,_ isRetry:Bool?)->Void){
        modelLayer.getStatData { (stat, errorMessage, isRetry)  in
            if let statistics = stat{
                onComplete(statistics,nil,nil)
            }else{
                onComplete(nil,errorMessage,isRetry)
            }
        }
    }
}
