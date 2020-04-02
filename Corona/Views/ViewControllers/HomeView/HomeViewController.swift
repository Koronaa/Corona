//
//  ViewController.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecordLabel: UILabel!
    
    fileprivate var commonPresenter:CommonPresenter!
    fileprivate var homePresenter:HomePresenter!
    fileprivate var overviewCellMaker:DependencyRegistry.OverviewCellMaker!
    fileprivate var hospitalCellMaker:DependencyRegistry.HopitalCellMaker!
    fileprivate var refreshControl = UIRefreshControl()
    
    func configure(with presenter:HomePresenter,
                   commonPresenter:CommonPresenter,
                   overviewCellMaker:@escaping DependencyRegistry.OverviewCellMaker,
                   hospitalCellMaker:@escaping DependencyRegistry.HopitalCellMaker){
        self.homePresenter = presenter
        self.commonPresenter = commonPresenter
        self.overviewCellMaker = overviewCellMaker
        self.hospitalCellMaker = hospitalCellMaker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupTableView()
        tableView.reloadData()
        self.setupUI(homePresenter: homePresenter)
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "OverviewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.OVERVIEW_TV_CELL)
        tableView.register(UINib(nibName: "HospitalDataTVCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.HOSPITALDATA_TV_CELL)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupRefreshControl(){
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func loadStatistics(from presenter:CommonPresenter){
        presenter.loadStatistics { (stats, errorMessage, isRetryAvailable) in
            self.refreshControl.endRefreshing()
            if let statistics = stats{
                self.homePresenter.statistics = statistics
                self.setupUI(homePresenter: self.homePresenter)
                self.setupTableView()
                self.tableView.reloadData()
            }else{
                UIHelper.makeSnackBar(message: errorMessage ?? "Error", type: .ERROR)
            }
        }
    }
    
    func setupUI(homePresenter:HomePresenter){
        dateTimeLabel.text = homePresenter.date
        if homePresenter.hospitalCount == 0{
            UIHelper.show(view: noRecordLabel)
        }else{
            UIHelper.hide(view: noRecordLabel)
        }
    }
    
    @objc func refresh() {
        loadStatistics(from: self.commonPresenter)
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.homePresenter.statistics!.hospitals.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let stat = self.homePresenter.statistics
            let cell = overviewCellMaker(tableView,indexPath,stat!)
            return cell
        case 1:
            let hospital = self.homePresenter.statistics!.hospitals[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 5, y: 1, width: 320, height: 20)
        myLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
        myLabel.textColor = .white
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 55/255, green: 79/255, blue: 112/255, alpha: 0.125)
        headerView.addSubview(myLabel)
        
        return headerView
    }
}

