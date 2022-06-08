//
//  Factory.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class Factory {
        
    func makeTabBar(viewModel: TabBarModel, comicsController: UINavigationController, favoriteController: UINavigationController, aboutController: UINavigationController) -> UITabBarController {
        
        comicsController.tabBarItem = UITabBarItem(title: viewModel.comicsTabBarItemTitle, image: viewModel.comicsTabBarItemImage, selectedImage: nil)
        favoriteController.tabBarItem = UITabBarItem(title: viewModel.favoriteTabBarItemTitle, image: viewModel.favoriteTabBarItemImage, selectedImage: nil)
        aboutController.tabBarItem = UITabBarItem(title: viewModel.aboutTabBarItemTitle, image: viewModel.aboutTabBarItemImage, selectedImage: nil)
        
        return TabBar(viewControllers: [comicsController, favoriteController, aboutController])
    }
}
