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
