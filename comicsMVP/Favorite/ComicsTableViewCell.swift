//
//  ComicsTableViewCell.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    
    var comicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var comicsImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        return image
    }()
    
    var favoriteButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "heart.fill")
        return button
    }()
    
    var whatIsFunnyButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "questionmark.circle")
        return button
    }()
    
    var comicsInfoButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "info.circle")
        return button

    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        contentView.addSubviews([comicsLabel, comicsImageView, favoriteButton, whatIsFunnyButton, comicsInfoButton])
        NSLayoutConstraint.activate([

            comicsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            comicsLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsLabel.heightAnchor.constraint(equalToConstant: 50),

            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 10),
            comicsImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            comicsImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 10),
            favoriteButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

            whatIsFunnyButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            whatIsFunnyButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            whatIsFunnyButton.heightAnchor.constraint(equalToConstant: 50),
            whatIsFunnyButton.widthAnchor.constraint(equalToConstant: 50),
            whatIsFunnyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            comicsInfoButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            comicsInfoButton.rightAnchor.constraint(equalTo: whatIsFunnyButton.leftAnchor),
            comicsInfoButton.heightAnchor.constraint(equalToConstant: 50),
            comicsInfoButton.widthAnchor.constraint(equalToConstant: 50),
            comicsInfoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
