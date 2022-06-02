//
//  ExtensionUIColor.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

extension UIColor {
    class var allBackgroundColor: UIColor {
        guard let color = UIColor(named: "allBackgroundColor") else { return UIColor.white }
        return color
    }
}
