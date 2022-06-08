//
//  ProfileViewController.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate {
                
    let cellComicsID = "ComicsTableViewCell"
            
    let tableView = UITableView.init(frame: .zero, style: .plain)
        
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ComicsTableViewCell.self, forCellReuseIdentifier: cellComicsID)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        setUpConstraint()
        tableView.separatorStyle = .none
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setUpConstraint() {
        tableView.toAutoLayout()
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ComicsStore.shared.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellComicsID, for: indexPath) as? ComicsTableViewCell else { fatalError()}
        let myComics = ComicsStore.shared.comics[indexPath.row]
        cell.comicsLabel.text = "\(myComics.title)"
        cell.comicsImageView.loadFrom(URLAddress: myComics.img)
        cell.comicsTableNumber = myComics.num
        cell.comicsInfoButton.onTap = {
            let alert = cell.showWhyFunny(alt: myComics.alt)
            self.present(alert, animated: true, completion: nil)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          500
      }
}
