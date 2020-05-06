//
//  StatServiceIMPL.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

protocol ModelLayer {
    func getStatData(onCompleted:@escaping (_ stat:Statistics?,_ error:Error?,_ isRetry:Bool)->Void)
}

class ModelLayerIMPL:ModelLayer{
    
    fileprivate let networkLayer:NetworkLayerIMPL
    fileprivate let translationLayer:TranslationLayerIMPL
    
    init(networkLayer:NetworkLayerIMPL,translationLayer:TranslationLayerIMPL) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    func getStatData(onCompleted:@escaping (_ stat:Statistics?,_ error:Error?,_ isRetry:Bool)->Void){
        networkLayer.getStatData { [weak self] networkObservable in
            if let _ = self{
                networkObservable
                    .subscribe(onNext: { (response,responseCode) in
                        if responseCode == 200{
                            if let jsonResponse = response as! JSON?{
                                self?.translationLayer.createStats(from: jsonResponse) { stats in
                                    onCompleted(stats,nil,false)
                                }
                            }
                        }else if responseCode == 515{
                            let error = Error(title: "No Connectivity!", message: "You are appear to be offline.")
                            onCompleted(nil,error,true)
                        }else{
                             let error = Error(title: "Service Error!", message: "Error while retrieving data.")
                            onCompleted(nil,error,true)
                        }
                    }).disposed(by: DisposeBag())
            }
        }
    }
}
