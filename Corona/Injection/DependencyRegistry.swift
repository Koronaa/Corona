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
    
    var container:Container {get}
    var navigationCoordinator:NavigationCoordinatorIMPL! {get}
    
    typealias HomeViewControllerMaker = (Statistics) -> HomeViewController
    func makeHomeViewController(with statistics:Statistics) -> HomeViewController
    
    typealias OverviewCellMaker = (UITableView,IndexPath,Statistics) -> OverviewTableViewCell
    func makeOverviewCell(for tableView: UITableView, at indexPath: IndexPath,with statistics:Statistics) -> OverviewTableViewCell
    
    typealias HopitalCellMaker = (UITableView,IndexPath,Hospital) -> HospitalDataTableViewCell
    func makeHospitalDataCell(for tableView: UITableView, at indexPath: IndexPath,with hospital:Hospital) -> HospitalDataTableViewCell
}

class DependencyRegistryIMPL:DependencyRegistry{
    
    var navigationCoordinator: NavigationCoordinatorIMPL!
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
        
        container.register(NavigationCoordinatorIMPL.self){(resolver,rootViewController:UIViewController) in
            return NavigationCoordinatorIMPL(with: rootViewController, registry: self)
        }.inObjectScope(.container)
    }
    
    func registerPresenters(){
        container.register(HomeViewModelIMPL.self) {(resolover , stats:Statistics) in HomeViewModelIMPL(statistics: stats)}
        container.register(CommonViewModelIMPL.self){resolover in CommonViewModelIMPL(modelLayer: resolover.resolve(ModelLayerIMPL.self)!)}
        container.register(OverviewTableViewCellPresenterIMPL.self){(resolover , stats:Statistics) in OverviewTableViewCellPresenterIMPL(statistics: stats)}
        container.register(HospitalDataTableViewCellPresenterIMPL.self) {(resolver, hospital:Hospital) in HospitalDataTableViewCellPresenterIMPL(hospital: hospital)}
    }
    
    func registerViewControllers(){
        container.register(HomeViewController.self) {(resolver, stat:Statistics) in
            let homePresenter = resolver.resolve(HomeViewModelIMPL.self, argument: stat)
            let commonPresenter = resolver.resolve(CommonViewModelIMPL.self)
            let homeVC = UIHelper.makeHomeViewController()
            homeVC.configure(with: homePresenter!, commonPresenter: commonPresenter!, overviewCellMaker: self.makeOverviewCell, hospitalCellMaker: self.makeHospitalDataCell)
            return homeVC
        }
    }
    
    func makeHomeViewController(with statistics:Statistics) -> HomeViewController{
        return container.resolve(HomeViewController.self, argument: statistics)!
    }
    
    func makeOverviewCell(for tableView: UITableView, at indexPath: IndexPath,with statistics:Statistics) -> OverviewTableViewCell{
        let presenter = container.resolve(OverviewTableViewCellPresenterIMPL.self, argument: statistics)!
        let cell = OverviewTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    func makeHospitalDataCell(for tableView: UITableView, at indexPath: IndexPath,with hospital:Hospital) -> HospitalDataTableViewCell{
        let presenter = container.resolve(HospitalDataTableViewCellPresenterIMPL.self, argument: hospital)!
        let cell = HospitalDataTableViewCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    func makeRootNavigationCoordinator(rootViewController:UIViewController) -> NavigationCoordinatorIMPL{
        navigationCoordinator = container.resolve(NavigationCoordinatorIMPL.self,argument: rootViewController)
        return navigationCoordinator
    }
    
}
