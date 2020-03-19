//
//  StatServiceIMPL.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON
class StatServiceIMPL{
    
    func getStatData(onCompleted:@escaping (_ stat:Statistics?,_ errorMessage:String?,_ isRetry:Bool)->Void){
        let statService = StatService()
        statService.getStatData { (response, responseCode) in
            if responseCode == 200{
                var hospitals:[Hospital] = []
                
                if let jsonResponse = response as! JSON?{
                    if let statData = jsonResponse["data"].dictionary{
                        if let dateTime = statData["update_date_time"]?.string,
                            let totalCases = statData["local_total_cases"]?.int,
                            let deaths = statData["local_deaths"]?.int,
                            let recovered = statData["local_recovered"]?.int{
                            
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
                                    let statData = Statistics(updatedDate: date, reportedCasesCount: totalCases, deathCount: deaths, recoveredCount: recovered, hospitals: hospitals)
                                    onCompleted(statData,nil,false)
                                }else{
                                    let statData = Statistics(updatedDate: date, reportedCasesCount: totalCases, deathCount: deaths, recoveredCount: recovered, hospitals: hospitals)
                                    onCompleted(statData,nil,false)
                                }
                            }else{
                                let statData = Statistics(updatedDate: date, reportedCasesCount: totalCases, deathCount: deaths, recoveredCount: recovered, hospitals: hospitals)
                                onCompleted(statData,nil,false)
                            }
                            
                        }
                    }
                }
            }else if responseCode == 515{
                onCompleted(nil,"You are appear to be offline. Please try again.",true)
            }else{
                onCompleted(nil,"Error while retrieving data. Please try again",true)
            }
        }
    }
    
    
}
