//
//  ComicsTableViewCell.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    
    var comicsTableNumber: Int?
    
    var comicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var comicsImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
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
    }
    
    func showWhyFunny(alt: String) -> UIAlertController {
        let alert = UIAlertController(title: "Explanation", message: alt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Show more", style: .default, handler: {(action) -> Void in
            guard let num = self.comicsTableNumber else {return}
            self.readAboutComics(num: num)}))
        return alert
    }
    
    func readAboutComics(num: Int) {
        let defaultURL = NSURL(string: "https://www.explainxkcd.com/wiki/index.php/\(num)")!
        UIApplication.shared.openURL(defaultURL as URL)
    }
    
    private func setUpConstraint() {
        contentView.addSubviews([comicsLabel, comicsImageView, favoriteButton, comicsInfoButton])
        NSLayoutConstraint.activate([

            comicsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            comicsLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsLabel.heightAnchor.constraint(equalToConstant: 50),
            comicsLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
            
            favoriteButton.bottomAnchor.constraint(equalTo: comicsLabel.bottomAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            
            comicsInfoButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            comicsInfoButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -10),
            comicsInfoButton.heightAnchor.constraint(equalToConstant: 50),
            comicsInfoButton.widthAnchor.constraint(equalToConstant: 25),

            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor),
            comicsImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            comicsImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
