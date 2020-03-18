//
//  ViewController.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var statistics:Statistics?
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStatistics()
        setupRefreshControl()
        
        
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "OverviewCell", bundle: .main), forCellReuseIdentifier: "overviewCell")
        tableView.register(UINib(nibName: "HospitalDataTVCell", bundle: .main), forCellReuseIdentifier: "hospitalDataCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupRefreshControl(){
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func loadStatistics(){
        let statServiceIMPL = StatServiceIMPL()
        statServiceIMPL.getStatData { (stat, errorMessage) in
            if let statistics = stat{
                print(statistics)
                self.statistics = statistics
                self.setupUI(date: statistics.updatedDate)
                self.setupTableView()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }else{
                print(errorMessage ?? "Error")
            }
        }
    }
    
    func setupUI(date:Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        dateTimeLabel.text = "Last updated on \(dateFormatter.string(from: date))"
    }
    
    @objc func refresh() {
        loadStatistics()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.statistics!.hospitals.count
        default:()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverviewTableViewCell
            cell.stat = self.statistics
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalDataCell", for: indexPath) as! HospitalDataTableViewCell
            cell.hospital = self.statistics!.hospitals[indexPath.row]
            return cell
        default:()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch  section {
        case 0:
            return 200.0
        case 1:
            return 213.0
        default:()
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Overall Status"
        case 1:
            return "Hospitals' Overview"
        default:()
        }
        return ""
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

