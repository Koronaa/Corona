//
//  UIHelper.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit
import TTGSnackbar

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
    
    static func makeSnackBar(message:String,type:SnackType = SnackType.ERROR){
          DispatchQueue.main.async {
              let snack = TTGSnackbar(message: message, duration: .long)
              snack.messageTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
              if type == SnackType.ERROR {
                  snack.backgroundColor = UIColor(displayP3Red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
              }else if type == SnackType.WARNING{
                  snack.backgroundColor = UIColor(displayP3Red: 248/255, green: 166/255, blue: 0/255, alpha: 1)
              }else{
                  snack.backgroundColor = UIColor(displayP3Red: 139/255, green: 195/255, blue: 74/255, alpha: 1)
              }
              snack.shouldDismissOnSwipe = true
              snack.show()
          }
      }
    
    static func hide(view:UIView){
        view.isHidden = true
    }
    
    static func show(view:UIView){
        view.isHidden = false
    }
}
