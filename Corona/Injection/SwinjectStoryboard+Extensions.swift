//
//  SwinjectStoryboard+Extensions.swift
//  Corona
//
//  Created by Sajith Konara on 4/1/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard{
    
    public class func setup(){
        if AppDelegate.dependencyRegistry == nil{
            AppDelegate.dependencyRegistry = DependencyRegistry(container: defaultContainer)
        }
        
        let dependencyRegistry:DependencyRegistry = AppDelegate.dependencyRegistry
        
        func main(){
            dependencyRegistry.container.storyboardInitCompleted(InitialViewController.self) { (resolver, viewController) in
                let commonPresenter = resolver.resolve(CommonPresenter.self)
                viewController.configure(with: commonPresenter!, homeViewControllerMaker: dependencyRegistry.makeHomeViewController)
            }
        }
        main()
    }
}
