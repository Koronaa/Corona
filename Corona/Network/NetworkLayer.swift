//
//  StatService.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum StatRouter{
    case getStat
    
    var url:URL{
        switch self {
        case .getStat:
            return URL(string: URLConstants.Api.Path.stat)!
        }
    }
    
    var method:HTTPMethod{
        switch self {
        case .getStat:
            return .get
        }
    }
}

protocol NetworkLayer {
    func getStatData(onResponse:onAPIResponse?)
}

class NetworkLayerIMPL:NetworkLayer{
    
    func getStatData(onResponse:onAPIResponse?){
        ServiceManager.APIRequest(url: StatRouter.getStat.url, method: StatRouter.getStat.method) { (response, responseCode) in
            if response != nil{
                let jsonData:JSON = JSON((response as! DataResponse<Any>).result.value!)
                onResponse?(jsonData,responseCode)
            }else{
                onResponse?(nil,responseCode)
            }
        }
    }
}
