//
//  TabBar.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class TabBar: UITabBarController {
    init(viewControllers: [UINavigationController]){
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        self.tabBar.backgroundColor = UIColor(named: "TabBarColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
