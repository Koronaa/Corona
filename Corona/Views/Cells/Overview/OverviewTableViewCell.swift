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
    @IBOutlet weak var rightSidedView: UIView!
    @IBOutlet weak var newDeathCountLabel: UILabel!
    @IBOutlet weak var newCasesCountLabel: UILabel!
    @IBOutlet weak var reportedCasesCountLabel: UILabel!
    @IBOutlet weak var recoveredCountLabel: UILabel!
    @IBOutlet weak var deathCountLabel: UILabel!
    
    
    fileprivate var overViewTableViewCellViewModel:OverviewTableViewCellViewModelIMPL!{
        didSet{
            setupCell()
            reportedCasesCountLabel.text = self.overViewTableViewCellViewModel.reportedCasesCount
            recoveredCountLabel.text = self.overViewTableViewCellViewModel.recoveredCount
            deathCountLabel.text = self.overViewTableViewCellViewModel.deathCount.delimiter
            
            let newCases = self.overViewTableViewCellViewModel.newCasesCount
            let newDeaths = self.overViewTableViewCellViewModel.newDeathCount
            
            if newCases > 0{
                UIHelper.show(view: newCasesCountLabel)
                newCasesCountLabel.text = "(+\(newCases.delimiter))"
            }else if newCases == 0{
                UIHelper.hide(view: newCasesCountLabel)
            }
            
            if self.overViewTableViewCellViewModel.deathCount > 0{
                if newDeaths > 0{
                    UIHelper.show(view: newDeathCountLabel)
                    newDeathCountLabel.text = "(+\(newDeaths.delimiter))"
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
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with viewModel: OverviewTableViewCellViewModelIMPL) -> OverviewTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.OVERVIEW_TV_CELL, for: indexPath) as! OverviewTableViewCell
        cell.overViewTableViewCellViewModel = viewModel
        return cell
    }
}
