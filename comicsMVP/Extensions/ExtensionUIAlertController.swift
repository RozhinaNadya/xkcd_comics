//
//  ExtensionUIAlertController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-07.
//

import UIKit

extension UIAlertController {
    
    class var wrongNumber: UIAlertController {
        let alert = UIAlertController(title: "Oops, something's wrong", message: "Please enter only numbers", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    class var noText: UIAlertController {
        let alert = UIAlertController(title: "Hmm..", message: "I don't see anything. Enter only number and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    class var whyFunnyError: UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "Buddy, I don't understand why this is so funny...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    class var notInfo: UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "Information not loaded yet", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    class var lastComics: UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "This is the last comics today", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    class var noComics: UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "We don't have so many comics :(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    class var firstComics: UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "The first comics on the screen", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
