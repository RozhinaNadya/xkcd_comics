//
//  ExtensionUIView.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .init(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.7
    }
}
