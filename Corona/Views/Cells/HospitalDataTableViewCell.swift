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
    
    
    var hospital:Hospital?{
        didSet{
            setupCell()
            hospitalNameLabel.text = self.hospital!.name
            totaTestedCountLabel.text = self.hospital!.totalTestedCount.description
            localTestedCountLabel.text = self.hospital!.localTestedCount.description
            foreignTestedCountLabel.text = self.hospital!.forignTestedCount.description
            foreignAdmittedCountLabel.text = self.hospital!.forignAdmittedCount.description
            totalAdmittedCountLabel.text = self.hospital!.totalAdmittedCount.description
            localAdmittedCountLabel.text = self.hospital!.localAdmittedCount.description
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
