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
    
    fileprivate var presenter:CommonPresenterIMPL!
    fileprivate var homeViewControllerMaker:DependencyRegistryIMPL.HomeViewControllerMaker!
    
    func configure(with commonPresenter:CommonPresenterIMPL,homeViewControllerMaker:@escaping DependencyRegistryIMPL.HomeViewControllerMaker){
        self.presenter = commonPresenter
        self.homeViewControllerMaker = homeViewControllerMaker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData(from: presenter)
    }
    
    private func loadData(from presenter:CommonPresenterIMPL){
        presenter.loadStatistics { (stats, errorMessage, isRetryAvailable) in
            if let statisticData = stats{
                let homeVC:HomeViewController = self.homeViewControllerMaker(statisticData)
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            }else{
                let error = errorMessage ?? "Something went wrong while retrieving data"
                if isRetryAvailable ?? false{
                    self.showRetrySnack(message: error)
                }else{
                    UIHelper.makeSnackBar(message: error)
                }
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
                                    self.loadData(from: self.presenter)
                                    
        })
        snackbar.backgroundColor = UIColor(displayP3Red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        snackbar.messageTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
        snackbar.actionTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
        snackbar.actionTextColor = UIColor.black
        snackbar.show()
    }
}
