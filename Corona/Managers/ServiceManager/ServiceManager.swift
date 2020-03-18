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

typealias onAPIResponse = (_ response:Any?, _ statusCode:Int)->()

class ServiceManager{
    
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,headers:HTTPHeaders? = nil,encoding:ParameterEncoding? = JSONEncoding.default,onResponse:onAPIResponse?){
        if ReachabilityManager.isConnectedToNetwork(){
            print ("Header: \(String(describing: headers))")
            print("Request URL: \(url)")
            print("Request Body: \(String(describing: params))")
            Alamofire.request(url, method: method, parameters: params, encoding: encoding!, headers: headers).responseJSON{ response in
                if let statusCode = response.response?.statusCode{
                    onResponse?(response,statusCode)
                }
            }
        }else{
            //        UIHelper.hideHUD()
            //        UIHelper.makeNoInternetAlert()
        }
    }
    
}
