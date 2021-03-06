//
//  FeedViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsViewController: UIViewController {
    
    var viewModel = ComicsModel()
    
    private var currentComics: ComicsData?
    
    private var lastNum: Int?
    
    private var prevButton = CustomButtonImage()
    
    private var nextButton = CustomButtonImage()
    
    private var numberButton = CustomButton()
    
    private var randomButton = CustomButton()
    
    private var favoriteButton = CustomButtonImage()
    
    private var comicsInfoButton = CustomButtonImage()
    
    private var comicsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private var comicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private var comicsImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    private var comicsNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var numberTextField: UITextField = {
        let text = UITextField()
        text.toAutoLayout()
        text.indent(size: 10)
        text.keyboardType = .asciiCapableNumberPad
        text.backgroundColor = .systemGray5
        text.textColor = .black
        text.font = .systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.tintColor = UIColor(named: "AccentColor")
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        return text
    }()
    
    private var numberRangeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        getJson(urlString: "https://xkcd.com/info.0.json")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraint()
        goStack()
        lastNumber()
        randomButton.onTap = {self.goRandomComics()}
        numberButton.onTap = {self.goNumberComics()}
        prevButton.onTap = {self.goPrevNumberComics()}
        nextButton.onTap = {self.goNextNumberComics()}
        favoriteButton.onTap = {self.addFavouriteComics()}
        comicsInfoButton.onTap = {self.goWhatIsFunnyButton()}
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let comicsForCheck = currentComics else {return}
        self.imageFavouriteButton(myComics: comicsForCheck)
    }
    
    private func numberRangeLabelPlaceholder() {
        guard let currentNumber = self.currentComics?.num else {return}
        guard let lastNumber = self.lastNum else {return}
        numberRangeLabel.text = "\(currentNumber) of \(lastNumber)"
    }
    
    private func imageFavouriteButton(myComics: ComicsData) {
        let img = ComicsStore.shared.comics.contains(myComics) ? "heart.fill" : "heart"
        self.favoriteButton.setImage(UIImage(systemName: img), for: .normal)
    }
    
    private func deleteComics(comicsForDelete: ComicsData) {
        if let index = ComicsStore.shared.comics.firstIndex(of: comicsForDelete) {
            ComicsStore.shared.comics.remove(at: index)
        }
        imageFavouriteButton(myComics: comicsForDelete)
    }
    
    private func goWhatIsFunnyButton() {
        guard let alt = self.currentComics?.alt else {return self.present(UIAlertController.whyFunnyError, animated: true, completion: nil)}
        self.showWhyFunny(alt: alt)
    }
    
    private func goComicsInfoButton() {
        guard let num: Int = self.currentComics?.num else {return self.present(UIAlertController.notInfo, animated: true, completion: nil)}
        self.readAboutComics(num: num)
    }
    
    private func goRandomComics() {
        guard let num = lastNum else {return print("last num in trouble")}
        let randomInt = Int.random(in: 1..<num)
        let newComicsUrl = "https://xkcd.com/\(randomInt)/info.0.json"
        self.getJson(urlString: newComicsUrl)
        numberTextField.text?.removeAll()
    }
    
    private func goNumberComics() {
        guard let stringNumber = self.numberTextField.text else {return
            self.present(UIAlertController.noText, animated: true, completion: nil)}
        print(stringNumber)
        guard let number = Int(stringNumber) else { return self.present(UIAlertController.wrongNumber, animated: true, completion: nil)
        }
        guard let checkNum = self.lastNum else {return}
        if number > checkNum {
            self.present(UIAlertController.noComics, animated: true, completion: nil)
        } else {
            let newComicsUrl = "https://xkcd.com/\(number)/info.0.json"
            self.getJson(urlString: newComicsUrl)
        }
        textFieldShouldReturn(numberTextField)
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func goPrevNumberComics() {
        guard let num: Int = self.currentComics?.num else {return print("currentComics?.num")}
        guard ((num - 1) != 0) else { return self.present(UIAlertController.firstComics, animated: true, completion: nil)
        }
        let newComicsUrl = "https://xkcd.com/\(num - 1)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    private func goNextNumberComics() {
        guard let num: Int = self.currentComics?.num else {return}
        if num == lastNum {
            self.present(UIAlertController.lastComics, animated: true, completion: nil)
        } else {
            let newComicsUrl = "https://xkcd.com/\(num + 1)/info.0.json"
            self.getJson(urlString: newComicsUrl)
        }
    }
    
    private func goStack() {
        self.comicsNumberStackView.addArrangedSubview(numberTextField)
        self.comicsNumberStackView.addArrangedSubview(numberButton)
    }
    
    private func setUpViewModel() {
        self.title = viewModel.title
        self.view.backgroundColor = viewModel.color
        self.favoriteButton.setImage(viewModel.favouriteButtonImg, for: .normal)
        self.comicsInfoButton.setImage(viewModel.comicsInfoButtonImg, for: .normal)
        self.prevButton.setImage(viewModel.prevButtonImg, for: .normal)
        self.nextButton.setImage(viewModel.nextButtonImg, for: .normal)
        self.numberButton.setTitle(viewModel.numberButtonTitle, for: .normal)
        self.randomButton.setTitle(viewModel.randomButtonTitle, for: .normal)
        self.numberTextField.placeholder = viewModel.numberTextFieldPlaceholder
    }
    
    private func addFavouriteComics() {
        guard let comics = self.currentComics else {return}
        if ComicsStore.shared.comics.contains(comics) {
            self.deleteComics(comicsForDelete: comics)
        } else {
            ComicsStore.shared.comics.append(comics)
        }
        imageFavouriteButton(myComics: comics)
    }
    
    private func readAboutComics(num: Int) {
        let defaultURL = NSURL(string: "https://www.explainxkcd.com/wiki/index.php/\(num)")!
        UIApplication.shared.openURL(defaultURL as URL)
    }
    
    private func showWhyFunny(alt: String) {
        let alert = UIAlertController(title: "Explanation", message: alt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Show more", style: .default, handler: {(action) -> Void in self.goComicsInfoButton()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpConstraint() {
        self.view.addSubview(comicsScrollView)
        comicsScrollView.addSubviews([randomButton, comicsLabel, comicsImageView, prevButton, nextButton, numberRangeLabel, favoriteButton, comicsInfoButton, comicsNumberStackView])
        NSLayoutConstraint.activate([
            
            comicsScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            comicsScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            comicsScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            comicsScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            comicsNumberStackView.topAnchor.constraint(equalTo: comicsScrollView.topAnchor),
            comicsNumberStackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsNumberStackView.heightAnchor.constraint(equalToConstant: 50),
            comicsNumberStackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            numberTextField.widthAnchor.constraint(equalToConstant: 80),
            numberButton.widthAnchor.constraint(equalToConstant: 60),
            
            comicsLabel.topAnchor.constraint(equalTo: comicsNumberStackView.bottomAnchor, constant: 20),
            comicsLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -140),
            
            favoriteButton.bottomAnchor.constraint(equalTo: comicsLabel.bottomAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            
            comicsInfoButton.bottomAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            comicsInfoButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -10),
            comicsInfoButton.heightAnchor.constraint(equalToConstant: 25),
            comicsInfoButton.widthAnchor.constraint(equalToConstant: 25),
            
            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 20),
            comicsImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            prevButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 20),
            prevButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            prevButton.heightAnchor.constraint(equalToConstant: 50),
            prevButton.widthAnchor.constraint(equalToConstant: 25),
            
            numberRangeLabel.topAnchor.constraint(equalTo: prevButton.topAnchor),
            numberRangeLabel.leftAnchor.constraint(equalTo: prevButton.rightAnchor),
            numberRangeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: numberRangeLabel.topAnchor),
            nextButton.leftAnchor.constraint(equalTo: numberRangeLabel.rightAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 25),
            
            randomButton.topAnchor.constraint(equalTo: nextButton.topAnchor),
            randomButton.heightAnchor.constraint(equalToConstant: 50),
            randomButton.widthAnchor.constraint(equalToConstant: 150),
            randomButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            randomButton.bottomAnchor.constraint(equalTo: comicsScrollView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComicsViewController {
    
    private func getJson(urlString: String) {
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
                self.currentComics = json
                self.imageFavouriteButton(myComics: json)
                self.numberRangeLabelPlaceholder()
            }
        }).resume()
    }
    
    private func lastNumber() {
        guard let myURL = URL(string: "https://xkcd.com/info.0.json") else { fatalError() }
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
                self.lastNum = json.num
                self.currentComics = json
                self.numberRangeLabelPlaceholder()
            }
        }).resume()
    }
}
