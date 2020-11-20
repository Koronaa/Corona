//
//  SharingManager.swift
//  Corona
//
//  Created by Sajith Konara on 10/31/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class SharingManager:OverviewViewModel{
    
    var statistics:Statistics!
    
    var newDeathCount:Int {return statistics.newDeathCount}
    var newCasesCount:Int {return statistics.newCasesCount}
    var reportedCasesCount:String {return statistics.reportedCasesCount.delimiter}
    var recoveredCount:String {return statistics.recoveredCount.delimiter}
    var deathCount:Int {return statistics.deathCount}
    var activeCasesCount:Int {return statistics.activeCasesCount}
    
    var dateString:String{
        let dateString = statistics.updatedDate
        return "Last updated on \(dateString.formattedDate)"
    }
    
    init(statistics:Statistics) {
        self.statistics = statistics
    }
    
    func createAsset(onCompleted : @escaping (_ imgae:UIImage?)->()){
        let size = CGSize.init(width: 54, height: 96)
        UIGraphicsBeginImageContextWithOptions(size, false, 20)
        if let context = UIGraphicsGetCurrentContext(){
            
            //// Color Declarations
            let cBlue = UIColor(red: 0.290, green: 0.373, blue: 0.494, alpha: 1.000)
            let cYellow = UIColor(red: 0.961, green: 0.765, blue: 0.267, alpha: 1.000)
            let textColor = UIColor(red: 0.286, green: 0.349, blue: 0.388, alpha: 1.000)
            let textColor2 = UIColor(red: 0.169, green: 0.416, blue: 0.651, alpha: 1.000)
            let cRed = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 0.751)
            
            //// Shadow Declarations
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.71)
            shadow.shadowOffset = CGSize(width: 0, height: -1)
            shadow.shadowBlurRadius = 5
            
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 54, height: 96))
            cBlue.setFill()
            rectanglePath.fill()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 6.0, y: 18.5, width: 42, height: 63.5), cornerRadius: 5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            UIColor.adaptiveWhite.setFill()
            rectangle2Path.fill()
            context.restoreGState()
            
            cYellow.setStroke()
            rectangle2Path.lineWidth = 1.5
            rectangle2Path.lineCapStyle = .round
            rectangle2Path.lineJoinStyle = .round
            rectangle2Path.stroke()
            
            
            //// headerRectangle Drawing
            let headerRectangleRect = CGRect(x: 6, y: 6, width: 42, height: 10)
            let headerRectangleTextContent = "HPB verified Sri Lankan figures of COVID-19"
            let headerRectangleStyle = NSMutableParagraphStyle()
            headerRectangleStyle.alignment = .center
            let headerRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3.5)!,
                .foregroundColor: cYellow,
                .paragraphStyle: headerRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let headerRectangleTextHeight: CGFloat = headerRectangleTextContent.boundingRect(with: CGSize(width: headerRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: headerRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: headerRectangleRect)
            headerRectangleTextContent.draw(in: CGRect(x: headerRectangleRect.minX, y: headerRectangleRect.minY + (headerRectangleRect.height - headerRectangleTextHeight) / 2, width: headerRectangleRect.width, height: headerRectangleTextHeight), withAttributes: headerRectangleFontAttributes)
            context.restoreGState()
            
            
            //// totalCasesTitleRectangle Drawing
            let totalCasesTitleRectangleRect = CGRect(x: 9, y: 21, width: 16, height: 4)
            let totalCasesTitleRectangleTextContent = "Total Cases"
            let totalCasesTitleRectangleStyle = NSMutableParagraphStyle()
            totalCasesTitleRectangleStyle.alignment = .left
            let totalCasesTitleRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3)!,
                .foregroundColor: textColor2,
                .paragraphStyle: totalCasesTitleRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let totalCasesTitleRectangleTextHeight: CGFloat = totalCasesTitleRectangleTextContent.boundingRect(with: CGSize(width: totalCasesTitleRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: totalCasesTitleRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: totalCasesTitleRectangleRect)
            totalCasesTitleRectangleTextContent.draw(in: CGRect(x: totalCasesTitleRectangleRect.minX, y: totalCasesTitleRectangleRect.minY + (totalCasesTitleRectangleRect.height - totalCasesTitleRectangleTextHeight) / 2, width: totalCasesTitleRectangleRect.width, height: totalCasesTitleRectangleTextHeight), withAttributes: totalCasesTitleRectangleFontAttributes)
            context.restoreGState()
            
            
            //// activeCasesTitleRectangle Drawing
            let activeCasesTitleRectangleRect = CGRect(x: 9, y: 36, width: 19, height: 4)
            let activeCasesTitleRectangleTextContent = "Active Cases"
            let activeCasesTitleRectangleStyle = NSMutableParagraphStyle()
            activeCasesTitleRectangleStyle.alignment = .left
            let activeCasesTitleRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3)!,
                .foregroundColor: textColor2,
                .paragraphStyle: activeCasesTitleRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let activeCasesTitleRectangleTextHeight: CGFloat = activeCasesTitleRectangleTextContent.boundingRect(with: CGSize(width: activeCasesTitleRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: activeCasesTitleRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: activeCasesTitleRectangleRect)
            activeCasesTitleRectangleTextContent.draw(in: CGRect(x: activeCasesTitleRectangleRect.minX, y: activeCasesTitleRectangleRect.minY + (activeCasesTitleRectangleRect.height - activeCasesTitleRectangleTextHeight) / 2, width: activeCasesTitleRectangleRect.width, height: activeCasesTitleRectangleTextHeight), withAttributes: activeCasesTitleRectangleFontAttributes)
            context.restoreGState()
            
            
            //// totalRecoveredTitleRectangle Drawing
            let totalRecoveredTitleRectangleRect = CGRect(x: 9, y: 51, width: 24, height: 4)
            let totalRecoveredTitleRectangleTextContent = "Total Recovered"
            let totalRecoveredTitleRectangleStyle = NSMutableParagraphStyle()
            totalRecoveredTitleRectangleStyle.alignment = .left
            let totalRecoveredTitleRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3)!,
                .foregroundColor: textColor2,
                .paragraphStyle: totalRecoveredTitleRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let totalRecoveredTitleRectangleTextHeight: CGFloat = totalRecoveredTitleRectangleTextContent.boundingRect(with: CGSize(width: totalRecoveredTitleRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: totalRecoveredTitleRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: totalRecoveredTitleRectangleRect)
            totalRecoveredTitleRectangleTextContent.draw(in: CGRect(x: totalRecoveredTitleRectangleRect.minX, y: totalRecoveredTitleRectangleRect.minY + (totalRecoveredTitleRectangleRect.height - totalRecoveredTitleRectangleTextHeight) / 2, width: totalRecoveredTitleRectangleRect.width, height: totalRecoveredTitleRectangleTextHeight), withAttributes: totalRecoveredTitleRectangleFontAttributes)
            context.restoreGState()
            
            
            //// reportedDeathTItleRectangle Drawing
            let reportedDeathTItleRectangleRect = CGRect(x: 9, y: 66, width: 24, height: 4)
            let reportedDeathTItleRectangleTextContent = "Reported Deaths"
            let reportedDeathTItleRectangleStyle = NSMutableParagraphStyle()
            reportedDeathTItleRectangleStyle.alignment = .left
            let reportedDeathTItleRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3)!,
                .foregroundColor: textColor2,
                .paragraphStyle: reportedDeathTItleRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let reportedDeathTItleRectangleTextHeight: CGFloat = reportedDeathTItleRectangleTextContent.boundingRect(with: CGSize(width: reportedDeathTItleRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: reportedDeathTItleRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: reportedDeathTItleRectangleRect)
            reportedDeathTItleRectangleTextContent.draw(in: CGRect(x: reportedDeathTItleRectangleRect.minX, y: reportedDeathTItleRectangleRect.minY + (reportedDeathTItleRectangleRect.height - reportedDeathTItleRectangleTextHeight) / 2, width: reportedDeathTItleRectangleRect.width, height: reportedDeathTItleRectangleTextHeight), withAttributes: reportedDeathTItleRectangleFontAttributes)
            context.restoreGState()
            
            
            //// totalCaseCountRectangle Drawing
            let totalCaseCountRectangleRect = CGRect(x: 9, y: 25, width: 35, height: 11)
            let totalCaseCountRectangleTextContent = reportedCasesCount
            let totalCaseCountRectangleStyle = NSMutableParagraphStyle()
            totalCaseCountRectangleStyle.alignment = .center
            let totalCaseCountRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 5)!,
                .foregroundColor: textColor,
                .paragraphStyle: totalCaseCountRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let totalCaseCountRectangleTextHeight: CGFloat = totalCaseCountRectangleTextContent.boundingRect(with: CGSize(width: totalCaseCountRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: totalCaseCountRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: totalCaseCountRectangleRect)
            totalCaseCountRectangleTextContent.draw(in: CGRect(x: totalCaseCountRectangleRect.minX, y: totalCaseCountRectangleRect.minY + (totalCaseCountRectangleRect.height - totalCaseCountRectangleTextHeight) / 2, width: totalCaseCountRectangleRect.width, height: totalCaseCountRectangleTextHeight), withAttributes: totalCaseCountRectangleFontAttributes)
            context.restoreGState()
            
            
            //// activeCountRectangle Drawing
            let activeCountRectangleRect = CGRect(x: 9, y: 40, width: 35, height: 11)
            let activeCountRectangleTextContent = activeCasesCount.delimiter
            let activeCountRectangleStyle = NSMutableParagraphStyle()
            activeCountRectangleStyle.alignment = .center
            let activeCountRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 5)!,
                .foregroundColor: textColor,
                .paragraphStyle: activeCountRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let activeCountRectangleTextHeight: CGFloat = activeCountRectangleTextContent.boundingRect(with: CGSize(width: activeCountRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: activeCountRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: activeCountRectangleRect)
            activeCountRectangleTextContent.draw(in: CGRect(x: activeCountRectangleRect.minX, y: activeCountRectangleRect.minY + (activeCountRectangleRect.height - activeCountRectangleTextHeight) / 2, width: activeCountRectangleRect.width, height: activeCountRectangleTextHeight), withAttributes: activeCountRectangleFontAttributes)
            context.restoreGState()
            
            
            //// totalRecoveredCountRectangle Drawing
            let totalRecoveredCountRectangleRect = CGRect(x: 9, y: 55, width: 35, height: 11)
            let totalRecoveredCountRectangleTextContent = recoveredCount
            let totalRecoveredCountRectangleStyle = NSMutableParagraphStyle()
            totalRecoveredCountRectangleStyle.alignment = .center
            let totalRecoveredCountRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 5)!,
                .foregroundColor: textColor,
                .paragraphStyle: totalRecoveredCountRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let totalRecoveredCountRectangleTextHeight: CGFloat = totalRecoveredCountRectangleTextContent.boundingRect(with: CGSize(width: totalRecoveredCountRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: totalRecoveredCountRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: totalRecoveredCountRectangleRect)
            totalRecoveredCountRectangleTextContent.draw(in: CGRect(x: totalRecoveredCountRectangleRect.minX, y: totalRecoveredCountRectangleRect.minY + (totalRecoveredCountRectangleRect.height - totalRecoveredCountRectangleTextHeight) / 2, width: totalRecoveredCountRectangleRect.width, height: totalRecoveredCountRectangleTextHeight), withAttributes: totalRecoveredCountRectangleFontAttributes)
            context.restoreGState()
            
            
            //// deathCountRectangle Drawing
            let deathCountRectangleRect = CGRect(x: 9, y: 70, width: 35, height: 11)
            let deathCountRectangleTextContent = deathCount.delimiter
            let deathCountRectangleStyle = NSMutableParagraphStyle()
            deathCountRectangleStyle.alignment = .center
            let deathCountRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 5)!,
                .foregroundColor: cRed,
                .paragraphStyle: deathCountRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let deathCountRectangleTextHeight: CGFloat = deathCountRectangleTextContent.boundingRect(with: CGSize(width: deathCountRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: deathCountRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: deathCountRectangleRect)
            deathCountRectangleTextContent.draw(in: CGRect(x: deathCountRectangleRect.minX, y: deathCountRectangleRect.minY + (deathCountRectangleRect.height - deathCountRectangleTextHeight) / 2, width: deathCountRectangleRect.width, height: deathCountRectangleTextHeight), withAttributes: deathCountRectangleFontAttributes)
            context.restoreGState()
            
            
            //// DateRectangle Drawing
            context.saveGState()
            context.setAlpha(0.6)
            
            let dateRectangleRect = CGRect(x: 0, y: 85, width: 54, height: 4)
            let dateRectangleTextContent = dateString
            let dateRectangleStyle = NSMutableParagraphStyle()
            dateRectangleStyle.alignment = .center
            let dateRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Light", size: 2)!,
                .foregroundColor: UIColor.white,
                .paragraphStyle: dateRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let dateRectangleTextHeight: CGFloat = dateRectangleTextContent.boundingRect(with: CGSize(width: dateRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: dateRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: dateRectangleRect)
            dateRectangleTextContent.draw(in: CGRect(x: dateRectangleRect.minX, y: dateRectangleRect.minY + (dateRectangleRect.height - dateRectangleTextHeight) / 2, width: dateRectangleRect.width, height: dateRectangleTextHeight), withAttributes: dateRectangleFontAttributes)
            context.restoreGState()
            
            context.restoreGState()
            
            
            //// todayDeathCountRectangle Drawing
            let todayDeathCountRectangleRect = CGRect(x: 9, y: 71, width: 35, height: 4)
            let todayDeathCountRectangleTextContent = newDeathCount >= 1 ? "+\(newDeathCount.description)" : ""
            let todayDeathCountRectangleStyle = NSMutableParagraphStyle()
            todayDeathCountRectangleStyle.alignment = .right
            let todayDeathCountRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3)!,
                .foregroundColor: cRed,
                .paragraphStyle: todayDeathCountRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let todayDeathCountRectangleTextHeight: CGFloat = todayDeathCountRectangleTextContent.boundingRect(with: CGSize(width: todayDeathCountRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: todayDeathCountRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: todayDeathCountRectangleRect)
            todayDeathCountRectangleTextContent.draw(in: CGRect(x: todayDeathCountRectangleRect.minX, y: todayDeathCountRectangleRect.minY + (todayDeathCountRectangleRect.height - todayDeathCountRectangleTextHeight) / 2, width: todayDeathCountRectangleRect.width, height: todayDeathCountRectangleTextHeight), withAttributes: todayDeathCountRectangleFontAttributes)
            context.restoreGState()
            
            
            //// todayTotalCasesCountRectangle Drawing
            let todayTotalCasesCountRectangleRect = CGRect(x: 9, y: 24, width: 35, height: 4)
            let todayTotalCasesCountRectangleTextContent = newCasesCount >= 1 ? "+\(newCasesCount.description)" : ""
            let todayTotalCasesCountRectangleStyle = NSMutableParagraphStyle()
            todayTotalCasesCountRectangleStyle.alignment = .right
            let color = HomeViewModelIMPL.isDarkModeON ? UIColor.white : textColor
            let todayTotalCasesCountRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Heavy", size: 3)!,
                .foregroundColor: color,
                .paragraphStyle: todayTotalCasesCountRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let todayTotalCasesCountRectangleTextHeight: CGFloat = todayTotalCasesCountRectangleTextContent.boundingRect(with: CGSize(width: todayTotalCasesCountRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: todayTotalCasesCountRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: todayTotalCasesCountRectangleRect)
            todayTotalCasesCountRectangleTextContent.draw(in: CGRect(x: todayTotalCasesCountRectangleRect.minX, y: todayTotalCasesCountRectangleRect.minY + (todayTotalCasesCountRectangleRect.height - todayTotalCasesCountRectangleTextHeight) / 2, width: todayTotalCasesCountRectangleRect.width, height: todayTotalCasesCountRectangleTextHeight), withAttributes: todayTotalCasesCountRectangleFontAttributes)
            context.restoreGState()
            
            
            //// watermarkRectangle Drawing
            context.saveGState()
            context.setAlpha(0.1)
            
            let watermarkRectangleRect = CGRect(x: 0, y: 92, width: 54, height: 4)
            let watermarkRectangleTextContent = "Powered by Koronå"
            let watermarkRectangleStyle = NSMutableParagraphStyle()
            watermarkRectangleStyle.alignment = .center
            let watermarkRectangleFontAttributes = [
                .font: UIFont(name: "Avenir-Light", size: 1.5)!,
                .foregroundColor: UIColor.white,
                .paragraphStyle: watermarkRectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            let watermarkRectangleTextHeight: CGFloat = watermarkRectangleTextContent.boundingRect(with: CGSize(width: watermarkRectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: watermarkRectangleFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: watermarkRectangleRect)
            watermarkRectangleTextContent.draw(in: CGRect(x: watermarkRectangleRect.minX, y: watermarkRectangleRect.minY + (watermarkRectangleRect.height - watermarkRectangleTextHeight) / 2, width: watermarkRectangleRect.width, height: watermarkRectangleTextHeight), withAttributes: watermarkRectangleFontAttributes)
            context.restoreGState()
            
            context.restoreGState()
        }
        
        if let newImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            onCompleted(newImage)
        }else{
            print("Error creating image")
            onCompleted(nil)
        }
    }
    
    func shareOnIG(image:UIImage?){
        if let image = image {
            guard let urlScheme = URL(string: "instagram-stories://share"),
                  let imageData = image.pngData() else {
                return
            }
            if UIApplication.shared.canOpenURL(urlScheme) {
                let pasterboardItems = [["com.instagram.sharedSticker.backgroundImage": imageData]]
                let pasterboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                UIPasteboard.general.setItems(pasterboardItems, options: pasterboardOptions)
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }
        }
    }
}
