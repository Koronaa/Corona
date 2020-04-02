//
//  StatServiceIMPL.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON
class ModelLayer{
    
    fileprivate let networkLayer:NetworkLayer
    fileprivate let translationLayer:TranslationLayer
    
    init(networkLayer:NetworkLayer,translationLayer:TranslationLayer) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    func getStatData(onCompleted:@escaping (_ stat:Statistics?,_ errorMessage:String?,_ isRetry:Bool)->Void){
        
        networkLayer.getStatData { (response, responseCode) in
            if responseCode == 200{
                if let jsonResponse = response as! JSON?{
                    self.translationLayer.createStats(from: jsonResponse) { stats in
                        onCompleted(stats,nil,false)
                    }
                }
            }else if responseCode == 515{
                onCompleted(nil,"You are appear to be offline. Please try again.",true)
            }else{
                onCompleted(nil,"Error while retrieving data. Please try again",true)
            }
        }
    }
}
