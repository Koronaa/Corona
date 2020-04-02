//
//  DependencyRegistry.swift
//  Corona
//
//  Created by Sajith Konara on 4/1/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class DependencyRegistry{
    
    var container:Container
    
    init(container:Container) {
        self.container = container
        
        Container.loggingFunction = nil
        
        registerDependencies()
        registerPresenters()
        registerViewControllers()
    }
    
    
    func registerDependencies(){
        container.register(NetworkLayer.self) { _ in NetworkLayer()}.inObjectScope(.container)
        container.register(TranslationLayer.self){_ in TranslationLayer()}.inObjectScope(.container)
        
        container.register(ModelLayer.self){resolver in
            ModelLayer(networkLayer: resolver.resolve(NetworkLayer.self)!, translationLayer: resolver.resolve(TranslationLayer.self)!)
        }.inObjectScope(.container)
    }
    
    func registerPresenters(){
        container.register(HomePresenter.self) {(resolover , stats:Statistics) in HomePresenter(statistics: stats)}
        container.register(CommonPresenter.self){resolover in CommonPresenter(modelLayer: resolover.resolve(ModelLayer.self)!)}
        container.register(OverviewTableViewCellPresenter.self){(resolover , stats:Statistics) in OverviewTableViewCellPresenter(statistics: stats)}
        container.register(HospitalDataTableViewCellPresenter.self) {(resolver, hospital:Hospital) in HospitalDataTableViewCellPresenter(hospital: hospital)}
    }
    
    func registerViewControllers(){
        container.register(HomeViewController.self) {(resolver, stat:Statistics) in
            let homePresenter = resolver.resolve(HomePresenter.self, argument: stat)
            let commonPresenter = resolver.resolve(CommonPresenter.self)
            let homeVC = UIHelper.makeHomeViewController()
            homeVC.configure(with: homePresenter!, commonPresenter: commonPresenter!, overviewCellMaker: self.makeOverviewCell, hospitalCellMaker: self.makeHospitalDataCell)
            return homeVC
        }
    }
    
    typealias HomeViewControllerMaker = (Statistics) -> HomeViewController
    func makeHomeViewController(with statistics:Statistics) -> HomeViewController{
        return container.resolve(HomeViewController.self, argument: statistics)!
    }
    
    typealias OverviewCellMaker = (UITableView,IndexPath,Statistics) -> OverviewTableViewCell
    func makeOverviewCell(for tableView: UITableView, at indexPath: IndexPath,with statistics:Statistics) -> OverviewTableViewCell{
        let presenter = container.resolve(OverviewTableViewCellPresenter.self, argument: statistics)!
        let cell = OverviewTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    typealias HopitalCellMaker = (UITableView,IndexPath,Hospital) -> HospitalDataTableViewCell
    func makeHospitalDataCell(for tableView: UITableView, at indexPath: IndexPath,with hospital:Hospital) -> HospitalDataTableViewCell{
        let presenter = container.resolve(HospitalDataTableViewCellPresenter.self, argument: hospital)!
        let cell = HospitalDataTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
}
