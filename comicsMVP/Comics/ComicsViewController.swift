//
//  FeedViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class ComicsViewController: UIViewController {
    
    var viewModel = ComicsModel()
    
    var comicsMonth: String?
    var comicsNum: Int?
    var comicsLink: String?
    var comicsYear: String?
    var comicsNews: String?
    var comicsSafe_title: String?
    var comicsTranscript: String?
    var comicsAlt: String?
    var comicsDay: String?
    var comicsImg: String?
    var comicsTitle: String?
    
    var lastNum: Int?
    
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
        button.tintColor = .white
        return button
    }()
    
    var whatIsFunnyButton: CustomButton = {
        let button = CustomButton(title: "What's so funny?")
        return button
    }()
    
    var comicsInfoButton: CustomButton = {
        let button = CustomButton(title: "")
        button.tintColor = .white
        return button
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setUpViewModel()
        getJson(urlString: "https://xkcd.com/info.0.json")
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
        whatIsFunnyButton.onTap = {
            guard let alt = self.comicsAlt else {return self.present(UIAlertController.whyFunny, animated: true, completion: nil)}
            self.showWhyFunny(alt: alt)
        }
        comicsInfoButton.onTap = {
            guard let num = self.comicsNum else {return self.present(UIAlertController.notInfo, animated: true, completion: nil)}
            self.readAboutComics(num: num)
        }
    }
    
    private func goRandomComics() {
        guard let num = lastNum else {return print("last num in trouble")}
        let randomInt = Int.random(in: 1..<num)
        let newComicsUrl = "https://xkcd.com/\(randomInt)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    private func goNumberComics() {
        guard let stringNumber = self.numberTextField.text else {return self.present(UIAlertController.noText, animated: true, completion: nil)}
        guard let number = Int(stringNumber) else { return self.present(UIAlertController.wrongNumber, animated: true, completion: nil)
        }
        let newComicsUrl = "https://xkcd.com/\(number)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    private func goPrevNumberComics() {
        guard let num: Int = self.comicsNum else {return print("not found self.comicsNum")}
        guard ((num - 1) != 0) else {return}
        let newComicsUrl = "https://xkcd.com/\(num - 1)/info.0.json"
        self.getJson(urlString: newComicsUrl)
    }
    
    func goNextNumberComics() {
        guard let num: Int = self.comicsNum else {return print("not found self.comicsNum")}
        let newComicsUrl = "https://xkcd.com/\(num + 1)/info.0.json"
        if NSURL(string: newComicsUrl) != nil {
            self.getJson(urlString: newComicsUrl)
        } else {
            return
        }

    }
    
    private func goStack() {
        self.comicsNumberStackView.addArrangedSubview(numberTextField)
        self.comicsNumberStackView.addArrangedSubview(numberButton)
    }
    
    private func setUpViewModel() {
        showComicsLabel.text = self.viewModel.showComicsLabelText
        self.title = viewModel.title
        self.view.backgroundColor = viewModel.color
        self.favoriteButton.setImage(viewModel.favouriteButtonImg, for: .normal)
        self.comicsInfoButton.setImage(viewModel.conicsInfoButtonImg, for: .normal)
    }
    
    private func addFavouriteComics() {
        guard let month = comicsMonth else { return print("not found month")}
        guard let num = comicsNum else { return print("not found num")}
        guard let link = comicsLink else { return print("not found month")}
        guard let year = comicsYear else { return print("not found year")}
        guard let news = comicsNews else { return print("not found news")}
        guard let safe_title = comicsSafe_title else { return print("not found safe_title")}
        guard let transcript = comicsTranscript else { return print("not found transcript")}
        guard let alt = comicsAlt else { return print("not found alt")}
        guard let img = comicsImg else { return print("not found img")}
        guard let title = comicsTitle else { return print("not found title")}
        guard let day = comicsDay else { return print("not found day")}

        let favouriteComics = ComicsData(month: month, num: num, link: link, year: year, news: news, safe_title: safe_title, transcript: transcript, alt: alt, img: img, title: title, day: day)
        ComicsStore.shared.comics.append(favouriteComics)
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
        comicsScrollView.addSubviews([comicsNumberStackView, randomButton, comicsLabel, comicsImageView, prevButton, nextButton, showComicsLabel, favoriteButton, whatIsFunnyButton, comicsInfoButton])
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
            
            comicsInfoButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 10),
            comicsInfoButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            comicsInfoButton.heightAnchor.constraint(equalToConstant: 50),
            comicsInfoButton.widthAnchor.constraint(equalToConstant: 50),
            
            whatIsFunnyButton.topAnchor.constraint(equalTo: comicsImageView.bottomAnchor, constant: 10),
            whatIsFunnyButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
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
            
                self.comicsImg = json.img
                self.comicsDay = json.day
                self.comicsAlt = json.alt
                self.comicsTranscript = json.transcript
                self.comicsSafe_title = json.safe_title
                self.comicsNews = json.news
                self.comicsYear = json.year
                self.comicsTitle = json.title
                self.comicsLink = json.link
                self.comicsMonth = json.month
                self.comicsNum = json.num
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
                self.numberTextField.placeholder = " max \(json.num)"
                self.lastNum = json.num
            }
        }).resume()
    }
}
