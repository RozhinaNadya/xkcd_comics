//
//  ExtensionUITextField.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-08.
//

import UIKit

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
