//
//  UIHelper.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift


enum SnackType:String{
    case ERROR = "ERROR"
    case WARNING = "WARNING"
    case NORMAL = "NORMAL"
}

class UIHelper{
    
    static func makeViewController(storyBoardName:String = UIConstants.StoryBoardName.MAIN, viewControllerName:String) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
    static func makeHomeViewController() -> HomeViewController{
        return makeViewController(viewControllerName: UIConstants.StoryBoardID.HOME_VC) as! HomeViewController
    }
    
    static func addShadow(to view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        view.layer.shadowOpacity = 0.4
    }
    
    static func addCornerRadius(to view:UIView,withRadius radius:CGFloat = 4, withborder:Bool = false,using borderColor:CGColor = UIColor.black.cgColor){
        view.layer.cornerRadius = radius
        if (withborder){
            view.layer.borderWidth = 0.5
            view.layer.borderColor = borderColor
        }
    }
    
    static func makeBanner(title:String,message:String,style:BannerStyle = .danger) -> GrowingNotificationBanner{
        return GrowingNotificationBanner(title: title, subtitle: message, style: style)
    }
    
    static func hide(view:UIView){
        view.isHidden = true
    }
    
    static func show(view:UIView){
        view.isHidden = false
    }
}
