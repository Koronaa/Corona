//
//  ServiceManager.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxAlamofire


typealias RxonAPIResponse = (_ observable:Observable<(Any?,Int)>)->()

class ServiceManager{
    
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,headers:HTTPHeaders? = nil,encoding:ParameterEncoding? = JSONEncoding.default,onResponse:@escaping RxonAPIResponse){
        if ReachabilityManager.isConnectedToNetwork(){
            Alamofire.request(url, method: method, parameters: params, encoding: encoding!, headers: headers).responseJSON{ response in
                if let statusCode = response.response?.statusCode{
                    onResponse(Observable.just((response,statusCode)))
                }
            }
        }else{
            onResponse(Observable.just((nil,515)))
        }
        
    }
    
    
}
