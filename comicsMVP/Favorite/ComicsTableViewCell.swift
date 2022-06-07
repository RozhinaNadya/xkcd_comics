//
//  ComicsTableViewCell.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    
    var comicsTableNumber: Int?
    
    var altLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    var comicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .systemFont(ofSize: 22, weight: .bold)
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
    
    var comicsInfoButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "info.circle")
        return button

    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraint()
        backgroundColor = .white
        comicsInfoButton.onTap = {
            guard let num = self.comicsTableNumber else {return}
            self.readAboutComics(num: num)
        }
    }
    
    private func readAboutComics(num: Int) {
        let defaultURL = NSURL(string: "https://www.explainxkcd.com/wiki/index.php/\(num)")!
        UIApplication.shared.openURL(defaultURL as URL)
    }
    
    private func setUpConstraint() {
        contentView.addSubviews([comicsLabel, comicsImageView, favoriteButton, altLabel, comicsInfoButton])
        NSLayoutConstraint.activate([

            comicsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            comicsLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            comicsLabel.heightAnchor.constraint(equalToConstant: 50),

            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor),
            comicsImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            comicsImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            altLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            altLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            altLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            altLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            favoriteButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            
            comicsInfoButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            comicsInfoButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            comicsInfoButton.heightAnchor.constraint(equalToConstant: 50),
            comicsInfoButton.widthAnchor.constraint(equalToConstant: 50),

            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
