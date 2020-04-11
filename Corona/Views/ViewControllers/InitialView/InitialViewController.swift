//
//  InitialViewController.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import TTGSnackbar
import RxSwift

class InitialViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var viewModel:CommonViewModelIMPL!
    fileprivate weak var navigationCoordinator:NavigationCoordinatorIMPL?
    fileprivate var bag = DisposeBag()
    
    func configure(with commonViewModel:CommonViewModelIMPL,navigationCoordinator:NavigationCoordinatorIMPL){
        self.viewModel = commonViewModel
        self.navigationCoordinator = navigationCoordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData(from: viewModel)
    }
    
    private func loadData(from viewModel:CommonViewModelIMPL){
        viewModel.loadStatistics { statRelay in
            statRelay.asObservable()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (stats, errorMessage, isRetryAvailable) in
                    guard let statistics = stats else{
                        let error = errorMessage ?? "Something went wrong while retrieving data"
                        if isRetryAvailable ?? false{
                            self.showRetrySnack(message: error)
                        }else{
                            UIHelper.makeSnackBar(message: error)
                        }
                        return
                    }
                    let args = ["stats":statistics]
                    self.navigationCoordinator?.next(arguments: args)
                }).disposed(by: self.bag)
        }
    }
    
    private func showRetrySnack(message:String){
        let snackbar = TTGSnackbar(message: message,
                                   duration: .forever,
                                   actionText: "Retry",
                                   actionBlock: { (snackbar) in
                                    snackbar.dismiss()
                                    self.activityIndicator.startAnimating()
                                    self.loadData(from: self.viewModel)
                                    
        })
        snackbar.backgroundColor = UIColor(displayP3Red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        snackbar.messageTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
        snackbar.actionTextFont = UIFont(name: "Avenir-Medium", size: 17.0)!
        snackbar.actionTextColor = UIColor.black
        snackbar.show()
    }
}
