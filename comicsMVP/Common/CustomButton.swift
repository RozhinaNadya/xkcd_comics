//
//  CustomButton.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

final class CustomButton: UIButton {
    private var title: String
    var onTap: (() -> Void)?
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        toAutoLayout()
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(named: "AccentColor")
        setTitleColor(UIColor.init(white: 1, alpha: 1), for: .normal)
        setTitleColor(UIColor.init(white: 1, alpha: 0.8), for: .selected)
        setTitleColor(UIColor.init(white: 1, alpha: 0.8), for: .highlighted)
        setTitleColor(UIColor.init(white: 1, alpha: 0.8), for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}

final class CustomButtonImage: UIButton {
    private var imgName: String
    var onTap: (() -> Void)?
    
    init(imgName: String) {
        self.imgName = imgName
        super.init(frame: .zero)
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .default)
        let image = UIImage(systemName: imgName, withConfiguration: config)
        setImage(image, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        toAutoLayout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}
