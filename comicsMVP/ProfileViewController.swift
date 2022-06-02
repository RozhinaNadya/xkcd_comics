//
//  ProfileViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var background: UIColor
    
    init(background: UIColor){
        self.background = background
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = background
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

