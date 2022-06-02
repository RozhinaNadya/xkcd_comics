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
}
