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
    
    
    var hospitalDataPresenter:HospitalDataTableViewCellPresenter!{
        didSet{
            setupCell()
            hospitalNameLabel.text = self.hospitalDataPresenter.hospitalName
            totaTestedCountLabel.text = self.hospitalDataPresenter.totalTestedCount
            localTestedCountLabel.text = self.hospitalDataPresenter.localTestedCount
            foreignTestedCountLabel.text = self.hospitalDataPresenter.foreignTestedCount
            foreignAdmittedCountLabel.text = self.hospitalDataPresenter.foreignAdmittedCount
            totalAdmittedCountLabel.text = self.hospitalDataPresenter.totalAdmittedCount
            localAdmittedCountLabel.text = self.hospitalDataPresenter.localAdmittedCount
        }
    }
    
    
    private func setupCell(){
        UIHelper.addCornerRadius(to: shadowView)
        UIHelper.addShadow(to: shadowView)
        UIHelper.addCornerRadius(to: leftView)
        UIHelper.addShadow(to: leftView)
        UIHelper.addCornerRadius(to: rightView)
        UIHelper.addShadow(to: rightView)
    }
    
}
