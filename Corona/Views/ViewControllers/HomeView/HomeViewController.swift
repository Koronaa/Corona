//
//  ViewController.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SkeletonView
import NotificationBannerSwift


class HomeViewController: UIViewController {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecordLabel: UILabel!
    
    fileprivate var homeViewModel:HomeViewModelIMPL!
    fileprivate var overviewCellMaker:DependencyRegistryIMPL.OverviewCellMaker!
    fileprivate var hospitalCellMaker:DependencyRegistryIMPL.HopitalCellMaker!
    fileprivate var refreshControl = UIRefreshControl()
    fileprivate var bag = DisposeBag()
    fileprivate var isRefreshTriggered:Bool = false
    
    func configure(with viewModel:HomeViewModelIMPL,
                   overviewCellMaker:@escaping DependencyRegistryIMPL.OverviewCellMaker,
                   hospitalCellMaker:@escaping DependencyRegistryIMPL.HopitalCellMaker){
        self.homeViewModel = viewModel
        self.overviewCellMaker = overviewCellMaker
        self.hospitalCellMaker = hospitalCellMaker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
        setupTableView()
        setupSkeleton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isRefreshTriggered = false
        loadStatistics(from: homeViewModel)
        setupRefreshControl()
    }
    
    private func setupObservables(){
        homeViewModel.statistics.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.refreshControl.endRefreshing()
                if !self.isRefreshTriggered{
                    self.tableView.hideSkeleton()
                    self.tableView.stopSkeletonAnimation()
                }
                self.tableView.reloadData()
                self.setupUI(homeViewModel: self.homeViewModel)
            }).disposed(by: bag)
        
        homeViewModel.error.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { errorMessage in
                self.refreshControl.endRefreshing()
                if let error = errorMessage{
                    var banner:GrowingNotificationBanner!
                    if self.isRefreshTriggered{
                        banner = UIHelper.makeBanner(title: error.title, message: error.message)
                    }else{
                        banner = self.showRetryBanner(title: error.title, message: error.message)
                    }
                    banner.show()
                }
            }).disposed(by: bag)
    }
    
    
    
    private func setupTableView(){
        tableView.register(UINib(nibName: "OverviewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.OVERVIEW_TV_CELL)
        tableView.register(UINib(nibName: "HospitalDataTVCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.HOSPITALDATA_TV_CELL)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupRefreshControl(){
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func setupSkeleton(){
        let gradient = SkeletonGradient(baseColor: UIColor(displayP3Red: 55/255, green: 79/255, blue: 112/255, alpha: 1))
        tableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil, transition: .none)
        tableView.startSkeletonAnimation()
    }
    
    private func loadStatistics(from viewModel:HomeViewModelIMPL){
        viewModel.loadStatistics()
    }
    
    private func setupUI(homeViewModel:HomeViewModelIMPL){
        dateTimeLabel.text = homeViewModel.date
        if homeViewModel.hospitalCount == 0{
            UIHelper.show(view: noRecordLabel)
        }else{
            UIHelper.hide(view: noRecordLabel)
        }
    }
    
    @objc private func refresh() {
        isRefreshTriggered = true
        loadStatistics(from: self.homeViewModel)
    }
    
    private func showRetryBanner(title:String,message:String) -> GrowingNotificationBanner{
        let banner = UIHelper.makeBanner(title: title, message: "\(message) Tap here to retry.")
        banner.autoDismiss = false
        banner.onTap = {
            banner.dismiss()
            self.isRefreshTriggered = false
            self.loadStatistics(from: self.homeViewModel)
        }
        return banner
    }
    
    private func showActivityViewController(for image:UIImage,in shareManager:SharingManager){
        let items: [Any] = [image]
        let activityViewController = TJActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.overrideActivityType("com.burbn.instagram.shareextension") {
            shareManager.shareOnIG(image: image)
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension HomeViewController:UITableViewDelegate,SkeletonTableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return homeViewModel.statistics.value != nil ? homeViewModel.hospitalCount : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let stat = self.homeViewModel.statistics.value
            let cell = overviewCellMaker(tableView,indexPath,stat!)
            return cell
        case 1:
            let hospital = self.homeViewModel.statistics.value!.hospitals[indexPath.row]
            let cell = hospitalCellMaker(tableView,indexPath,hospital)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch  section {
        case 0:
            return 200.0
        case 1:
            return 213.0
        default:
            return 0.0
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Overall Status"
        case 1:
            return "Hospitals' Overview"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let stat = self.homeViewModel.statistics.value{
                let shareManager = SharingManager(statistics: stat)
                shareManager.createAsset(onCompleted: { (image) in
                    if let image = image{
                        self.showActivityViewController(for: image,in: shareManager)
                    }
                })
            }
        default:()
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 1, width: 320, height: 20)
        myLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
        myLabel.textColor = .white
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 55/255, green: 79/255, blue: 112/255, alpha: 0.125)
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let section = indexPath.section
        switch section {
        case 0:
            return UIConstants.Cell.OVERVIEW_TV_CELL
        case 1:
            return UIConstants.Cell.HOSPITALDATA_TV_CELL
        default:
            return ""
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 1
        case 1:
            switch DeviceManager.getDeviceType() {
            case .iPhone_5_5s_5C_SE:
                return 1
            case .iPhone_XsMax_11ProMax,.iPhone_Xr_11:
                return 3
            default:
                return 2
            }
            
        default:
            return 1
        }
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 2
    }
}

