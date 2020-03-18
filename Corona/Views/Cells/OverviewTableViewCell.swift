//
//  OverviewTableViewCell.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var reportedCasesCountLabel: UILabel!
    @IBOutlet weak var recoveredCountLabel: UILabel!
    @IBOutlet weak var deathCountLabel: UILabel!
    
    
    var stat:Statistics?{
        didSet{
            setupCell()
            reportedCasesCountLabel.text = self.stat!.reportedCasesCount.description
            recoveredCountLabel.text = self.stat!.recoveredCount.description
            deathCountLabel.text = self.stat!.deathCount.description
        }
    }
    
    private func setupCell(){
        UIHelper.addShadow(to: shadowView)
        UIHelper.addCornerRadius(to: shadowView)
    }
    
    
}
