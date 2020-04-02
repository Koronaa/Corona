//
//  HospitalDataTableViewCellPresenter.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

protocol HospitalDataTableViewCellPresenter {
    var hospitalName:String {get}
    var totalTestedCount:String {get}
    var localTestedCount:String {get}
    var foreignTestedCount:String {get}
    var foreignAdmittedCount:String {get}
    var totalAdmittedCount:String {get}
    var localAdmittedCount:String {get}
}

class HospitalDataTableViewCellPresenterIMPL:HospitalDataTableViewCellPresenter{
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
