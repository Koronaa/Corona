//
//  OverviewTableViewCell.swift
//  Corona
//
//  Created by Sajith Konara on 3/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var rightSidedView: UIView!
    @IBOutlet weak var newDeathCountLabel: UILabel!
    @IBOutlet weak var newCasesCountLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var reportedCasesCountLabel: UILabel!
    @IBOutlet weak var recoveredCountLabel: UILabel!
    @IBOutlet weak var deathCountLabel: UILabel!
    
    
    var stat:Statistics?{
        didSet{
            setupCell()
            reportedCasesCountLabel.text = self.stat!.reportedCasesCount.delimiter
            recoveredCountLabel.text = self.stat!.recoveredCount.delimiter
            deathCountLabel.text = self.stat!.deathCount.delimiter
            
            let newCases = self.stat!.newCasesCount
            let newDeaths = self.stat!.newDeathCount
            
            if newCases > 0{
                UIHelper.show(view: newCasesCountLabel)
                newCasesCountLabel.text = "(+\(newCases))"
            }else if newCases == 0{
                UIHelper.hide(view: newCasesCountLabel)
            }
            
            if self.stat!.deathCount > 0{
                if newDeaths > 0{
                    UIHelper.show(view: newDeathCountLabel)
                    newDeathCountLabel.text = "(+\(newDeaths))"
                }else if newDeaths == 0{
                    UIHelper.hide(view: newDeathCountLabel)
                }
            }else{
                UIHelper.hide(view: newDeathCountLabel)
            }
        }
    }
    
    private func setupCell(){
        UIHelper.addShadow(to: shadowView)
        UIHelper.addCornerRadius(to: shadowView)
    }
}
