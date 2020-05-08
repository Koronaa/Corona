//
//  Statistics.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Statistics:Decodable {
    var updatedDate:String
    var reportedCasesCount:Int
    var deathCount:Int
    var recoveredCount:Int
    var newCasesCount:Int
    var newDeathCount:Int
    var activeCasesCount:Int
    var hospitals:[Hospital]
    
    enum CodingKeys:String,CodingKey{
        case updatedDate = "update_date_time"
        case reportedCasesCount = "local_total_cases"
        case deathCount = "local_deaths"
        case recoveredCount = "local_recovered"
        case newCasesCount = "local_new_cases"
        case newDeathCount = "local_new_deaths"
        case activeCasesCount = "local_active_cases"
        case hospitals = "hospital_data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        updatedDate = try container.decode(String.self, forKey: .updatedDate)
        reportedCasesCount = try container.decode(Int.self, forKey: .reportedCasesCount)
        deathCount = try container.decode(Int.self, forKey: .deathCount)
        recoveredCount = try container.decode(Int.self, forKey: .recoveredCount)
        newCasesCount = try container.decode(Int.self, forKey: .newCasesCount)
        newDeathCount = try container.decode(Int.self, forKey: .newDeathCount)
        activeCasesCount = try container.decode(Int.self, forKey: .activeCasesCount)
        hospitals = try container.decode([Hospital].self, forKey: .hospitals)
    }
    
}
