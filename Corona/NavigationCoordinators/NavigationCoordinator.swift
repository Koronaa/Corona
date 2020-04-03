//
//  NavigationCoordinator.swift
//  Corona
//
//  Created by Sajith Konara on 4/3/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

protocol NavigationCoordinator {
    func next(arguments:Dictionary<String,Any>?)
}

enum NavigationState {
    case atSplash
    case atHome
}


class NavigationCoordinatorIMPL:NavigationCoordinator {
    
    var registry:DependencyRegistry
    var rootViewController:UIViewController
    
    var currentNavState:NavigationState = .atSplash
    
    init(with rootViewController:UIViewController,registry:DependencyRegistry) {
        self.rootViewController = rootViewController
        self.registry = registry
    }
    
    
    
    func next(arguments: Dictionary<String, Any>?) {
        switch currentNavState {
        case .atSplash:
            showHomeViewController(arguments:arguments)
        case .atHome:
            break
        }
    }
    
    func showHomeViewController(arguments:Dictionary<String,Any>?){
        guard let stats = arguments?["stats"] as? Statistics else {
            print("Couln't find any stats")
            return
        }
        let homeViewController = registry.makeHomeViewController(with: stats)
        homeViewController.modalPresentationStyle = .fullScreen
        rootViewController.present(homeViewController, animated: true, completion: nil)
        currentNavState = .atHome
    }
    
    
}
