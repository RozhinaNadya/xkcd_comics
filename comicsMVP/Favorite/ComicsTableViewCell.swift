//
//  ComicsTableViewCell.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    
    var comicsCellScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
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
    
    var favoriteButton: CustomButton = {
        let button = CustomButton(title: "")
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        contentView.addSubview(comicsCellScrollView)
        comicsCellScrollView.addSubviews([comicsLabel, comicsImageView, favoriteButton])
        NSLayoutConstraint.activate([
            
            comicsCellScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            comicsCellScrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            comicsCellScrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            comicsCellScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
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
            favoriteButton.bottomAnchor.constraint(equalTo: comicsCellScrollView.bottomAnchor, constant: -20),
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
