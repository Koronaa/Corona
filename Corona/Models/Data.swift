//
//  Data.swift
//  Corona
//
//  Created by Sajith Konara on 5/8/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Data:Decodable {
    var statistics:Statistics
    
    enum CodingKeys:String,CodingKey{
        case statistics = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statistics = try container.decode(Statistics.self, forKey: .statistics)
    }
}
