//
//  CharacterDetailVC.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit
import RxSwift

class CharacterDetailVC: BaseViewController {
    
    @IBOutlet weak var imageViewCharacter: UIImageView! {
        didSet {
            imageViewCharacter.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var labelCharacterName: UILabel! {
        didSet {
            labelCharacterName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            labelCharacterName.textColor = .black
            labelCharacterName.textAlignment = .left
            labelCharacterName.numberOfLines = 0
            labelCharacterName.lineBreakMode = .byWordWrapping
        }
    }
    
    @IBOutlet weak var labelDescription: UILabel! {
        didSet {
            labelDescription.font = UIFont.systemFont(ofSize: 15, weight: .light)
            labelDescription.textColor = .black
            labelDescription.textAlignment = .left
            labelDescription.numberOfLines = 0
            labelDescription.lineBreakMode = .byWordWrapping
        }
    }
    
    @IBOutlet private weak var tableViewComics: UITableView! {
        didSet {
            tableViewComics.delegate = self
            tableViewComics.dataSource = self
            tableViewComics.separatorStyle = .none
            tableViewComics.showsVerticalScrollIndicator = false
            tableViewComics.register(UINib(nibName: ComicsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ComicsTableViewCell.reuseIdentifier)
        }
    }
    
    var viewModel: CharacterDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacter()
        
        getComics()
        
    }
    
    private func getCharacter() {
        viewModel?.getCharacter()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.updateUI()
            }, onError: { [weak self] error in
                guard let self = self else { return }
            }).disposed(by: disposeBag)
    }
    
    private func getComics() {
        viewModel?.getComics()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.tableViewComics.reloadData()
            }, onError: { [weak self] error in
                guard let self = self else { return }
            }).disposed(by: disposeBag)
    }
    
    private func updateUI() {
        labelCharacterName.text = viewModel?.characterName ?? ""
        labelDescription.text = viewModel?.description ?? ""
        imageViewCharacter.setImage(urlString: viewModel?.imageUrl ?? "")
    }
}

// MARK: - UITableViewDelegate
extension CharacterDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comicsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? ComicsTableViewCell
        cell?.comicsTableViewCellVM = viewModel?.getComicsTableViewCellVM(at: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
