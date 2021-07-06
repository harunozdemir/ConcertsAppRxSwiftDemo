//
//  CharacterListVC.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit
import RxSwift
import ViewAnimator

class CharacterListVC: BaseViewController {
    
    @IBOutlet private weak var tableViewCharacters: UITableView! {
        didSet {
            tableViewCharacters.delegate = self
            tableViewCharacters.dataSource = self
            tableViewCharacters.separatorStyle = .singleLine
            tableViewCharacters.showsVerticalScrollIndicator = false
            tableViewCharacters.register(UINib(nibName: CharactersTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CharactersTableViewCell.reuseIdentifier)
            tableViewCharacters.register(UINib(nibName: LoadingTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        }
    }
    
    private let viewModel: CharacterListVM = CharacterListVM()
    private var isLoading = false
    private var limit = 0
    private let limitMultiplier = 30
    private var isHiddenLoadingCell = false
    private let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Marvel Characters"
        loadMoreData()
    }
    
    private func getCharacters() {
        viewModel.getCharacters(limit: limit)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
//                self.tableViewCharacters.reloadData()
                UIView.animate(views: self.tableViewCharacters.visibleCells, animations: self.animations, reversed: true,
                                      initialAlpha: 1.0, finalAlpha: 0.0, completion: {
                                        self.tableViewCharacters.reloadData()
                       })
                self.isLoading = false
                self.isHiddenLoadingCell = self.viewModel.allCharacters.isEmpty
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.isHiddenLoadingCell = true
                self.tableViewCharacters.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func loadMoreData() {
        if !isLoading {
            isLoading = true
            limit += limitMultiplier
            getCharacters()
        }
    }
}

// MARK: - UITableViewDelegate
extension CharacterListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = CharacterDetailVC.loadFromNib() as? CharacterDetailVC else {
            return
        }
        detailVC.viewModel = CharacterDetailVM(id: viewModel.allCharacters[indexPath.row].id)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.characterCount
        } else if section == 1 { // loading cell
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? CharactersTableViewCell
            cell?.charactersTableViewCellVM = viewModel.getCharactersTableViewCellVM(at: indexPath.row)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? LoadingTableViewCell
            
            cell?.activityIndicator.startAnimating()
            cell?.isHidden = isHiddenLoadingCell
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
 
}