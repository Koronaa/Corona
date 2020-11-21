//
//  HospitalDataTableViewCell.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class HospitalDataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var hospitalNameLabel: UILabel!
    @IBOutlet weak var totaTestedCountLabel: UILabel!
    @IBOutlet weak var localTestedCountLabel: UILabel!
    @IBOutlet weak var foreignTestedCountLabel: UILabel!
    @IBOutlet weak var foreignAdmittedCountLabel: UILabel!
    @IBOutlet weak var totalAdmittedCountLabel: UILabel!
    @IBOutlet weak var localAdmittedCountLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    
    fileprivate var hospitalDataViewModel:HospitalDataTableViewCellViewModelIMPL!{
        didSet{
            setupCell()
            hospitalNameLabel.text = self.hospitalDataViewModel.hospitalName
            totaTestedCountLabel.text = self.hospitalDataViewModel.totalTestedCount
            localTestedCountLabel.text = self.hospitalDataViewModel.localTestedCount
            foreignTestedCountLabel.text = self.hospitalDataViewModel.foreignTestedCount
            foreignAdmittedCountLabel.text = self.hospitalDataViewModel.foreignAdmittedCount
            totalAdmittedCountLabel.text = self.hospitalDataViewModel.totalAdmittedCount
            localAdmittedCountLabel.text = self.hospitalDataViewModel.localAdmittedCount
        }
    }
    
    
    private func setupCell(){
        UIHelper.addCornerRadius(to: shadowView)
        UIHelper.addShadow(to: shadowView)
        UIHelper.addCornerRadius(to: leftView)
        UIHelper.addShadow(to: leftView)
        UIHelper.addCornerRadius(to: rightView)
        UIHelper.addShadow(to: rightView)
        leftView.backgroundColor = UIColor.adaptiveWhite
        rightView.backgroundColor = UIColor.adaptiveWhite
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with viewModel: HospitalDataTableViewCellViewModelIMPL) -> HospitalDataTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.HOSPITALDATA_TV_CELL, for: indexPath) as! HospitalDataTableViewCell
        cell.hospitalDataViewModel = viewModel
        return cell
    }
    
}
