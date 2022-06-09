//
//  CustomButton.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

final class CustomButton: UIButton {
    var onTap: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
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
    var onTap: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
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
