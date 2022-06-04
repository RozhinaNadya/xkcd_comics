//
//  FeedViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsViewController: UIViewController {
    
    var viewModel = ComicsModel()
    
    var comicsScrollView: UIScrollView = {
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
    
    var comicsNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    var numberTextField: UITextField = {
        let text = UITextField()
        text.toAutoLayout()
        text.backgroundColor = .white
        text.textColor = .black
        text.font = .systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.tintColor = UIColor(named: "AccentColor")
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        return text
    }()
    
    var showComicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    
    var prevButton: CustomButton = {
        let button = CustomButton(title: "< Prev")
        return button
    }()
    
    var nextButton: CustomButton = {
        let button = CustomButton(title: "Next >")
        return button
    }()
    
    var numberButton: CustomButton = {
        let button = CustomButton(title: "Show")
        return button
    }()
    
    var randomButton: CustomButton = {
        let button = CustomButton(title: "Show random comics")
        return button
    }()
    
    var favoriteButton: CustomButton = {
        let button = CustomButton(title: "")
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    var whatIsFunnyButton: CustomButton = {
        let button = CustomButton(title: "What's so funny?")
 
        return button
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraint()
        goStack()
        getJson(urlString: "https://xkcd.com/info.0.json")
        randomButton.onTap = {self.goRandomComics()}
        numberButton.onTap = {self.goNumberComics()}
        prevButton.onTap = {self.goPrevNumberComics()}
        nextButton.onTap = {self.goNextNumberComics()}
    }
    
    func goRandomComics() {
        let randomInt = Int.random(in: 1..<2625)
        let newComicsUrl = "https://xkcd.com/\(randomInt)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    func goNumberComics() {
        guard let stringNumber = self.numberTextField.text else {return}
        guard let number = Int(stringNumber) else { return }
        let newComicsUrl = "https://xkcd.com/\(number)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    func goPrevNumberComics() {
        print("goPrevNumberComics")
        guard let stringNumber = self.numberTextField.text else {return}
        guard var number = Int(stringNumber) else { return }
        guard (number - 1) != nil else {return}
        let newNumber: () = number -= 1
        let newComicsUrl = "https://xkcd.com/\(newNumber)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    func goNextNumberComics() {
        guard let stringNumber = self.numberTextField.text else {return}
        guard var number = Int(stringNumber) else { return }
        let newNumber = (number -= 1)

    }
    
    func goStack() {
        self.comicsNumberStackView.addArrangedSubview(numberTextField)
        self.comicsNumberStackView.addArrangedSubview(numberButton)
    }
    
    func setUpViewModel() {
        numberTextField.placeholder = self.viewModel.numberTextFieldPlaceholder
        showComicsLabel.text = self.viewModel.showComicsLabelText
        self.title = viewModel.title
        self.view.backgroundColor = viewModel.color
    }
    
    private func setUpConstraint() {
        self.view.addSubview(comicsScrollView)
        comicsScrollView.addSubviews([comicsNumberStackView, randomButton, comicsLabel, comicsImageView, prevButton, nextButton, showComicsLabel, favoriteButton, whatIsFunnyButton])
        NSLayoutConstraint.activate([
            
            comicsScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            comicsScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            comicsScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            comicsScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            randomButton.topAnchor.constraint(equalTo: comicsScrollView.topAnchor, constant: 20),
            randomButton.heightAnchor.constraint(equalToConstant: 50),
            randomButton.widthAnchor.constraint(equalToConstant: self.view.frame.width - 180),
            randomButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            randomButton.leftAnchor.constraint(equalTo: comicsScrollView.leftAnchor, constant: 90),
            
            prevButton.topAnchor.constraint(equalTo: randomButton.topAnchor),
            prevButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            prevButton.heightAnchor.constraint(equalToConstant: 50),
            prevButton.widthAnchor.constraint(equalToConstant: 60),
            
            nextButton.topAnchor.constraint(equalTo: randomButton.topAnchor),
            nextButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 60),

            showComicsLabel.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 20),
            showComicsLabel.leftAnchor.constraint(equalTo: prevButton.leftAnchor),
            showComicsLabel.heightAnchor.constraint(equalToConstant: 50),

            comicsNumberStackView.topAnchor.constraint(equalTo: showComicsLabel.topAnchor),
            comicsNumberStackView.leftAnchor.constraint(equalTo: showComicsLabel.rightAnchor, constant: 5),
            comicsNumberStackView.heightAnchor.constraint(equalToConstant: 50),
            comicsNumberStackView.widthAnchor.constraint(equalToConstant: 145),
            numberTextField.widthAnchor.constraint(equalToConstant: 80),
            numberButton.widthAnchor.constraint(equalToConstant: 60),
            
            comicsLabel.topAnchor.constraint(equalTo: comicsNumberStackView.bottomAnchor, constant: 10),
            comicsLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsLabel.heightAnchor.constraint(equalToConstant: 50),

            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 10),
            comicsImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            comicsImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            
            whatIsFunnyButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 10),
            whatIsFunnyButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            whatIsFunnyButton.heightAnchor.constraint(equalToConstant: 50),
            whatIsFunnyButton.widthAnchor.constraint(equalToConstant: 150),
            
            favoriteButton.topAnchor.constraint(equalTo: whatIsFunnyButton.topAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.bottomAnchor.constraint(equalTo: comicsScrollView.bottomAnchor, constant: -20),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComicsViewController {
    
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
