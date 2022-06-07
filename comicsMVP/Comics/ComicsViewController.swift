//
//  FeedViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsViewController: UIViewController {
            
    var viewModel = ComicsModel()
    
    var currentComics: ComicsData?
    
    var lastNum: Int?
    
    var comicsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    var comicsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    var comicsImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
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
        text.backgroundColor = .systemGray5
        text.textColor = .black
        text.font = .systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.tintColor = UIColor(named: "AccentColor")
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        return text
    }()
    
    var numberRangeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    
    var prevButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "chevron.left")
        return button
    }()
    
    var nextButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "chevron.right")
        return button
    }()
    
    var numberButton: CustomButton = {
        let button = CustomButton(title: "Show")
        return button
    }()
    
    var randomButton: CustomButton = {
        let button = CustomButton(title: "Next random")
        return button
    }()
    
    var favoriteButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "heart")
        return button
    }()
    
    var whatIsFunnyButton: CustomButton = {
        let button = CustomButton(title: "What's so funny?")
        return button
    }()
    
    var comicsInfoButton: CustomButtonImage = {
        let button = CustomButtonImage(imgName: "info.circle")
        return button
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
        getJson(urlString: "https://xkcd.com/info.0.json")
        numberTextField.placeholder = " I want comics number..."
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
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
        whatIsFunnyButton.onTap = {self.goWhatIsFunnyButton()}
        comicsInfoButton.onTap = {self.goComicsInfoButton()}
    }
    
    private func imageFavouriteButton(myComics: ComicsData) {

        let img = ComicsStore.shared.comics.contains(myComics) ? "heart.fill" : "heart"
        self.favoriteButton.setImage(UIImage(systemName: img), for: .normal)
    }
    
    private func goWhatIsFunnyButton() {
        guard let alt = self.currentComics?.alt else {return self.present(UIAlertController.whyFunny, animated: true, completion: nil)}

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
        self.nextButton.backgroundColor = UIColor(named: "AccentColor")
    }
    
    private func goNumberComics() {
        guard let stringNumber = self.numberTextField.text else {return self.present(UIAlertController.noText, animated: true, completion: nil)}
        guard let number = Int(stringNumber) else { return self.present(UIAlertController.wrongNumber, animated: true, completion: nil)
        }
        let newComicsUrl = "https://xkcd.com/\(number)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    private func goPrevNumberComics() {
        guard let num: Int = self.currentComics?.num else {return print("currentComics?.num")}
        guard ((num - 1) != 0) else { return self.present(UIAlertController.firstComics, animated: true, completion: nil)
        }
        let newComicsUrl = "https://xkcd.com/\(num - 1)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    private func goNextNumberComics() {
        guard let num: Int = self.currentComics?.num else {return print("currentComics?.num")}
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
   //     showComicsLabel.text = self.viewModel.showComicsLabelText
        self.title = viewModel.title
        self.view.backgroundColor = viewModel.color
        self.favoriteButton.setImage(viewModel.favouriteButtonImg, for: .normal)
        self.comicsInfoButton.setImage(viewModel.conicsInfoButtonImg, for: .normal)
    }
    
    private func addFavouriteComics() {
        guard let comics = self.currentComics else {return}
        ComicsStore.shared.comics.append(comics)
    }
    
    private func readAboutComics(num: Int) {
        let defaultURL = NSURL(string: "https://www.explainxkcd.com/wiki/index.php/\(num)")!
        UIApplication.shared.openURL(defaultURL as URL)
    }
    
    private func showWhyFunny(alt: String) {
        let alert = UIAlertController(title: "Explanation", message: alt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpConstraint() {
        self.view.addSubview(comicsScrollView)
        comicsScrollView.addSubviews([comicsNumberStackView, randomButton, comicsLabel, comicsImageView, prevButton, nextButton, numberRangeLabel, favoriteButton, comicsInfoButton])
        NSLayoutConstraint.activate([
            
            comicsScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            comicsScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            comicsScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            comicsScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            comicsNumberStackView.topAnchor.constraint(equalTo: comicsScrollView.topAnchor),
            comicsNumberStackView.leftAnchor.constraint(equalTo: comicsScrollView.leftAnchor, constant: 20),
            comicsNumberStackView.heightAnchor.constraint(equalToConstant: 30),
            comicsNumberStackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            numberTextField.widthAnchor.constraint(equalToConstant: 80),
            numberButton.widthAnchor.constraint(equalToConstant: 60),
            
            comicsLabel.topAnchor.constraint(equalTo: comicsNumberStackView.bottomAnchor, constant: 40),
            comicsLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 140),

            favoriteButton.bottomAnchor.constraint(equalTo: comicsLabel.bottomAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            
            comicsInfoButton.bottomAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            comicsInfoButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            comicsInfoButton.heightAnchor.constraint(equalToConstant: 50),
            comicsInfoButton.widthAnchor.constraint(equalToConstant: 50),
            
            comicsImageView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 20),
            comicsImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            prevButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 20),
            prevButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            prevButton.heightAnchor.constraint(equalToConstant: 50),
            prevButton.widthAnchor.constraint(equalToConstant: 50),
            
            numberRangeLabel.topAnchor.constraint(equalTo: prevButton.topAnchor),
            numberRangeLabel.leftAnchor.constraint(equalTo: prevButton.rightAnchor),
            numberRangeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: numberRangeLabel.topAnchor),
            nextButton.leftAnchor.constraint(equalTo: numberRangeLabel.rightAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            
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
                self.numberRangeLabel.text = "\(json.num) of \(json.num))"

            }
        }).resume()
    }
}
