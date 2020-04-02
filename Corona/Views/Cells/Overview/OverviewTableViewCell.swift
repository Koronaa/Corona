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
    
    
    fileprivate var overViewTableViewCellPresenter:OverviewTableViewCellPresenter!{
        didSet{
            setupCell()
            reportedCasesCountLabel.text = self.overViewTableViewCellPresenter.reportedCasesCount
            recoveredCountLabel.text = self.overViewTableViewCellPresenter.recoveredCount
            deathCountLabel.text = self.overViewTableViewCellPresenter.deathCount.delimiter
            
            let newCases = self.overViewTableViewCellPresenter.newCasesCount
            let newDeaths = self.overViewTableViewCellPresenter.newDeathCount
            
            if newCases > 0{
                UIHelper.show(view: newCasesCountLabel)
                newCasesCountLabel.text = "(+\(newCases.delimiter))"
            }else if newCases == 0{
                UIHelper.hide(view: newCasesCountLabel)
            }
            
            if self.overViewTableViewCellPresenter.deathCount > 0{
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
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with presenter: OverviewTableViewCellPresenter) -> OverviewTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.OVERVIEW_TV_CELL, for: indexPath) as! OverviewTableViewCell
        cell.overViewTableViewCellPresenter = presenter
        return cell
    }
}
