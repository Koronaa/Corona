//
//  StatService.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

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
    func getStatData(onResponse:@escaping RxonAPIResponse)
}

class NetworkLayerIMPL:NetworkLayer{
    
    fileprivate var bag = DisposeBag()
    
    func getStatData(onResponse:@escaping RxonAPIResponse){
        ServiceManager.APIRequest(url: StatRouter.getStat.url, method: StatRouter.getStat.method) { serviceObservable in
            serviceObservable.subscribe(onNext: { responseData, responseCode in
                if responseData != nil{
                    onResponse(Observable.just((responseData,responseCode)))
                }else{
                    onResponse(serviceObservable)
                }
            }).disposed(by: self.bag)
        }
    }
}
