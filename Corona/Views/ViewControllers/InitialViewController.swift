//
//  InitialViewController.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import TTGSnackbar

class InitialViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadStatistics()
    }
    
    private func loadStatistics(){
        let statServiceIMPL = StatServiceIMPL()
        statServiceIMPL.getStatData { (stat, errorMessage, isRetry)  in
            if let statistics = stat{
                let homeVC = UIHelper.makeHomeViewController()
                homeVC.statistics = statistics
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            }else{
                self.showRetrySnack(message: errorMessage ?? "Error")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func showRetrySnack(message:String){
         let snackbar = TTGSnackbar(message: message,
                                    duration: .forever,
                                    actionText: "Retry",
                                    actionBlock: { (snackbar) in
                                     snackbar.dismiss()
                                     self.activityIndicator.startAnimating()
                                     self.loadStatistics()
         })
         snackbar.backgroundColor = UIColor(displayP3Red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
         snackbar.messageTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
         snackbar.actionTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
         snackbar.actionTextColor = UIColor.black
         snackbar.show()
     }
}
