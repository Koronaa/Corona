//
//  TranslationLayer.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

protocol TranslationLayer {
    func createStats(from responseData:Foundation.Data,onCompleted: @escaping (_ stats:Statistics) -> Void)
}

class TranslationLayerIMPL:TranslationLayer{
    
    func createStats(from responseData:Foundation.Data,onCompleted: @escaping (_ stats:Statistics) -> Void){
        let decorder = JSONDecoder()
        do{
            let data = try decorder.decode(Data.self, from: responseData)
            onCompleted(data.statistics)
        }catch{
            print(error)
        }
    }
}
