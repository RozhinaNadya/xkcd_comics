//
//  AboutAuthorViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-08.
//

import UIKit

class AboutAuthorViewController: UIViewController {
    
    private var viewModel = AboutAuthorModel()
    
    private var aboutScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private var authorImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        return image
    }()
    
    private var licenseButton = CustomButton()
    
    private var licenseTextLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
        licenseButton.onTap = {self.readAboutLicense()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraint()
    }
    
    private func readAboutLicense() {
        let defaultURL = NSURL(string: "https://xkcd.com/license.html")!
        UIApplication.shared.openURL(defaultURL as URL)
    }
    
    private func setUpViewModel() {
        self.view.backgroundColor = viewModel.color
        self.authorImageView.loadFrom(URLAddress: viewModel.authorImage)
        self.licenseButton.setTitle(viewModel.licenseButtonTitle, for: .normal)
        self.licenseTextLabel.text = viewModel.licenseText
    }
    
    private func setUpConstraint() {
        self.view.addSubview(aboutScrollView)
        aboutScrollView.addSubviews([authorImageView, licenseButton, licenseTextLabel])
        NSLayoutConstraint.activate([
            aboutScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            aboutScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            aboutScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            aboutScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            authorImageView.topAnchor.constraint(equalTo: aboutScrollView.topAnchor, constant: 100),
            authorImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            
            licenseTextLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 20),
            licenseTextLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            licenseTextLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            licenseButton.topAnchor.constraint(equalTo: licenseTextLabel.bottomAnchor, constant: 50),
            licenseButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            licenseButton.heightAnchor.constraint(equalToConstant: 50),
            licenseButton.widthAnchor.constraint(equalToConstant: 150),
            licenseButton.bottomAnchor.constraint(equalTo: aboutScrollView.bottomAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
