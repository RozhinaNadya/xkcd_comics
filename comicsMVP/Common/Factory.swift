//
//  Factory.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class Factory {
    
    func makeTabBar(viewModel: TabBarModel, feedController: UINavigationController, profileController: UINavigationController) -> UITabBarController {
        
        feedController.tabBarItem = UITabBarItem(title: viewModel.feedTabBarItemTitle, image: viewModel.feedTabBarItemImage, selectedImage: nil)
        profileController.tabBarItem = UITabBarItem(title: viewModel.profileTabBarItemTitle, image: viewModel.profileTabBarItemImage, selectedImage: nil)
        
        return TabBar(viewControllers: [feedController, profileController])
    }
}
