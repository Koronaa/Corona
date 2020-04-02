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

protocol DependencyRegistry {
    typealias HomeViewControllerMaker = (Statistics) -> HomeViewController
    func makeHomeViewController(with statistics:Statistics) -> HomeViewController
    
    typealias OverviewCellMaker = (UITableView,IndexPath,Statistics) -> OverviewTableViewCell
    func makeOverviewCell(for tableView: UITableView, at indexPath: IndexPath,with statistics:Statistics) -> OverviewTableViewCell
    
    typealias HopitalCellMaker = (UITableView,IndexPath,Hospital) -> HospitalDataTableViewCell
    func makeHospitalDataCell(for tableView: UITableView, at indexPath: IndexPath,with hospital:Hospital) -> HospitalDataTableViewCell
}

class DependencyRegistryIMPL:DependencyRegistry{
    
    var container:Container
    
    init(container:Container) {
        self.container = container
        
        Container.loggingFunction = nil
        
        registerDependencies()
        registerPresenters()
        registerViewControllers()
    }
    
    
    func registerDependencies(){
        container.register(NetworkLayerIMPL.self) { _ in NetworkLayerIMPL()}.inObjectScope(.container)
        container.register(TranslationLayerIMPL.self){_ in TranslationLayerIMPL()}.inObjectScope(.container)
        
        container.register(ModelLayerIMPL.self){resolver in
            ModelLayerIMPL(networkLayer: resolver.resolve(NetworkLayerIMPL.self)!, translationLayer: resolver.resolve(TranslationLayerIMPL.self)!)
        }.inObjectScope(.container)
    }
    
    func registerPresenters(){
        container.register(HomePresenterIMPL.self) {(resolover , stats:Statistics) in HomePresenterIMPL(statistics: stats)}
        container.register(CommonPresenterIMPL.self){resolover in CommonPresenterIMPL(modelLayer: resolover.resolve(ModelLayerIMPL.self)!)}
        container.register(OverviewTableViewCellPresenterIMPL.self){(resolover , stats:Statistics) in OverviewTableViewCellPresenterIMPL(statistics: stats)}
        container.register(HospitalDataTableViewCellPresenterIMPL.self) {(resolver, hospital:Hospital) in HospitalDataTableViewCellPresenterIMPL(hospital: hospital)}
    }
    
    func registerViewControllers(){
        container.register(HomeViewController.self) {(resolver, stat:Statistics) in
            let homePresenter = resolver.resolve(HomePresenterIMPL.self, argument: stat)
            let commonPresenter = resolver.resolve(CommonPresenterIMPL.self)
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
        let presenter = container.resolve(OverviewTableViewCellPresenterIMPL.self, argument: statistics)!
        let cell = OverviewTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    typealias HopitalCellMaker = (UITableView,IndexPath,Hospital) -> HospitalDataTableViewCell
    func makeHospitalDataCell(for tableView: UITableView, at indexPath: IndexPath,with hospital:Hospital) -> HospitalDataTableViewCell{
        let presenter = container.resolve(HospitalDataTableViewCellPresenterIMPL.self, argument: hospital)!
        let cell = HospitalDataTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
}
