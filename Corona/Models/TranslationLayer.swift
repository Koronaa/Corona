//
//  TranslationLayer.swift
//  Corona
//
//  Created by Sajith Konara on 3/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol TranslationLayer {
    func createStats(from response:JSON,onCompleted: @escaping (_ stats:Statistics) -> Void)
}

class TranslationLayerIMPL:TranslationLayer{
    
    func createStats(from response:JSON,onCompleted: @escaping (_ stats:Statistics) -> Void){
        var hospitals:[Hospital] = []
        if let statData = response["data"].dictionary{
            if let dateTime = statData["update_date_time"]?.string,
                let totalCases = statData["local_total_cases"]?.int,
                let deaths = statData["local_deaths"]?.int,
                let recovered = statData["local_recovered"]?.int,
                let newCases = statData["local_new_cases"]?.int,
                let newDeaths = statData["local_new_deaths"]?.int  {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
                let date = dateFormatter.date(from: dateTime) ?? Date()
                
                if let hospitalData = statData["hospital_data"]?.array{
                    if hospitalData.count > 0{
                        for hospital in hospitalData{
                            if let hospitalInfo = hospital["hospital"].dictionary{
                                if let name = hospitalInfo["name"]?.string,
                                    let totalTested = hospital["cumulative_total"].int,
                                    let localTested = hospital["cumulative_local"].int,
                                    let foreignTested = hospital["cumulative_foreign"].int,
                                    let totalAdmitted = hospital["treatment_total"].int,
                                    let localAdmitted = hospital["treatment_local"].int,
                                    let forignAdmitted = hospital["treatment_foreign"].int{
                                    
                                    let hospital = Hospital(name: name, totalTestedCount: totalTested, localTestedCount: localTested, forignTestedCount: foreignTested, totalAdmittedCount: totalAdmitted, localAdmittedCount: localAdmitted, forignAdmittedCount: forignAdmitted)
                                    hospitals.append(hospital)
                                }
                            }
                        }
                        let statData = Statistics(updatedDate: date, reportedCasesCount: totalCases, deathCount: deaths, recoveredCount: recovered, newCasesCount: newCases, newDeathCount: newDeaths, hospitals: hospitals)
                        onCompleted(statData)
                    }else{
                        let statData = Statistics(updatedDate: date, reportedCasesCount: totalCases, deathCount: deaths, recoveredCount: recovered, newCasesCount: newCases, newDeathCount: newDeaths, hospitals: hospitals)
                        onCompleted(statData)
                    }
                }else{
                    let statData = Statistics(updatedDate: date, reportedCasesCount: totalCases, deathCount: deaths, recoveredCount: recovered, newCasesCount: newCases, newDeathCount: newDeaths, hospitals: hospitals)
                    onCompleted(statData)
                }
                
            }
        }
    }
    
}
