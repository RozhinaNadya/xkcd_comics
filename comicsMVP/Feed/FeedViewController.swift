//
//  FeedViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class FeedViewController: UIViewController {
    
    var feedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    var comicsNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    var numberTextField: UITextField = {
        let text = UITextField()
        text.toAutoLayout()
        text.placeholder = " Number of comics "
        text.backgroundColor = .white
        text.textColor = .black
        text.font = .systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.tintColor = UIColor(named: "AccentColor")
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        return text
    }()
    
    var numberButton: CustomButton = {
        let button = CustomButton(title: " Show this comics ")
        return button
    }()
    
    var randomButton: CustomButton = {
        let button = CustomButton(title: " Show random comics ")
        return button
    }()
        
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .allBackgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        goStack()
    }
    
    func goStack() {
        self.comicsNumberStackView.addArrangedSubview(numberTextField)
        self.comicsNumberStackView.addArrangedSubview(numberButton)
    }
    
    func setUp() {
        self.view.addSubview(feedScrollView)
        feedScrollView.addSubviews([comicsNumberStackView, randomButton])
        NSLayoutConstraint.activate([
            feedScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            feedScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            feedScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            feedScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            comicsNumberStackView.centerXAnchor.constraint(equalTo: feedScrollView.centerXAnchor),
            comicsNumberStackView.centerYAnchor.constraint(equalTo: feedScrollView.centerYAnchor),
            comicsNumberStackView.leftAnchor.constraint(equalTo: feedScrollView.leftAnchor, constant: 20),
            comicsNumberStackView.heightAnchor.constraint(equalToConstant: 100),
            numberTextField.heightAnchor.constraint(equalToConstant: 50),
            numberButton.heightAnchor.constraint(equalToConstant: 50),
            randomButton.topAnchor.constraint(equalTo: comicsNumberStackView.bottomAnchor, constant: 10),
            randomButton.heightAnchor.constraint(equalToConstant: 50),
            randomButton.leftAnchor.constraint(equalTo: comicsNumberStackView.leftAnchor),
            randomButton.rightAnchor.constraint(equalTo: comicsNumberStackView.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
