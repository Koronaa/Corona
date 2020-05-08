//
//  ServiceManager.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift



typealias RxonAPIResponse = (_ observable:Observable<(Foundation.Data?,Int)>)->()

class ServiceManager{
    
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,headers:HTTPHeaders? = nil,encoding:ParameterEncoding? = JSONEncoding.default,onResponse:@escaping RxonAPIResponse){
        if ReachabilityManager.isConnectedToNetwork(){
            AF.request(url, method: method, parameters: params, encoding: encoding!, headers: headers).responseJSON{ response in
                switch response.result{
                case .success(_):
                    if let statusCode = response.response?.statusCode{
                        onResponse(Observable.just((response.data,statusCode)))
                    }
                default:()
                }
            }
        }else{
            onResponse(Observable.just((nil,515)))
        }
    }
}
