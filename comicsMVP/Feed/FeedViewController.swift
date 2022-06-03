//
//  FeedViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class FeedViewController: UIViewController {
    
    var comics: [ComicsData]!
    
    var feedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    var comicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "label"
        return label
    }()
    
    var comicsImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.loadFrom(URLAddress: "https://imgs.xkcd.com/comics/woodpecker.png")
        return image
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
        text.placeholder = "Number of comics"
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
        let button = CustomButton(title: "Show this comics")
        return button
    }()
    
    var randomButton: CustomButton = {
        let button = CustomButton(title: "Show random comics")
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
        randomButton.onTap = {
            self.getJson(urlString: "https://xkcd.com/610/info.0.json")
        }
    }
    
    func goStack() {
        self.comicsNumberStackView.addArrangedSubview(numberTextField)
        self.comicsNumberStackView.addArrangedSubview(numberButton)
    }
    
    func setUp() {
        self.view.addSubview(feedScrollView)
        feedScrollView.addSubviews([comicsNumberStackView, randomButton, comicsLabel, comicsImageView])
        NSLayoutConstraint.activate([
            
            feedScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            feedScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            feedScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            feedScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            comicsLabel.topAnchor.constraint(equalTo: feedScrollView.topAnchor, constant: 20),
            comicsLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            comicsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 10),
            comicsImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            comicsImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            
            comicsNumberStackView.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 20),
            comicsNumberStackView.leftAnchor.constraint(equalTo: comicsLabel.leftAnchor),
            comicsNumberStackView.rightAnchor.constraint(equalTo: comicsLabel.rightAnchor),
            comicsNumberStackView.heightAnchor.constraint(equalToConstant: 100),
            numberTextField.heightAnchor.constraint(equalToConstant: 50),
            numberButton.heightAnchor.constraint(equalToConstant: 50),
            randomButton.topAnchor.constraint(equalTo: comicsNumberStackView.bottomAnchor, constant: 10),
            randomButton.heightAnchor.constraint(equalToConstant: 50),
            randomButton.leftAnchor.constraint(equalTo: comicsNumberStackView.leftAnchor),
            randomButton.rightAnchor.constraint(equalTo: comicsNumberStackView.rightAnchor),
            randomButton.bottomAnchor.constraint(equalTo: feedScrollView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedViewController {
    
    func getJson(urlString: String) {
        guard let myURL = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: myURL, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            var comicsData: ComicsData?
            do {
                 comicsData = try JSONDecoder().decode(ComicsData.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            guard let json = comicsData else {
                return
            }
            DispatchQueue.main.async {
                self.comicsLabel.text = json.title
                self.comicsImageView.loadFrom(URLAddress: json.img)
            }
        }).resume()
    }
}
