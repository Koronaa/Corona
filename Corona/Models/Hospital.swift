//
//  Hospital.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Hospital:Decodable{
    var name:String
    var totalTestedCount:Int
    var localTestedCount:Int
    var forignTestedCount:Int
    var totalAdmittedCount:Int
    var localAdmittedCount:Int
    var forignAdmittedCount:Int
    
    enum CodingKeys:String,CodingKey{
        case name = "hospital"
        case totalTestedCount = "cumulative_total"
        case localTestedCount = "cumulative_local"
        case forignTestedCount = "cumulative_foreign"
        case totalAdmittedCount = "treatment_total"
        case localAdmittedCount = "treatment_local"
        case forignAdmittedCount = "treatment_foreign"
    }
    
    enum HospitalKeys:String,CodingKey{
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hospital = try container.nestedContainer(keyedBy: HospitalKeys.self, forKey: .name)
        name = try hospital.decode(String.self, forKey: .name)
        totalTestedCount = try container.decode(Int.self, forKey: .totalTestedCount)
        localTestedCount = try container.decode(Int.self, forKey: .localTestedCount)
        forignTestedCount = try container.decode(Int.self, forKey: .forignTestedCount)
        totalAdmittedCount = try container.decode(Int.self, forKey: .totalAdmittedCount)
        localAdmittedCount = try container.decode(Int.self, forKey: .localAdmittedCount)
        forignAdmittedCount = try container.decode(Int.self, forKey: .forignAdmittedCount)
    }
}
