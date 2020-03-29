//
//  HospitalDataTableViewCellPresenter.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class HospitalDataTableViewCellPresenter{
    var hospital:Hospital!
    
    var hospitalName:String {return hospital.name}
    var totalTestedCount:String {return hospital.totalTestedCount.description}
    var localTestedCount:String {return hospital.localTestedCount.description}
    var foreignTestedCount:String {return hospital.forignTestedCount.description}
    var foreignAdmittedCount:String {return hospital.forignAdmittedCount.description}
    var totalAdmittedCount:String {return hospital.totalAdmittedCount.description}
    var localAdmittedCount:String {return hospital.localAdmittedCount.description}
    
    init(hospital:Hospital) {
        self.hospital = hospital
    }
}
