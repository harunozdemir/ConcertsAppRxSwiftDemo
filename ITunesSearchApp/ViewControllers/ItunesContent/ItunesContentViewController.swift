//
//  ItunesContentViewController.swift
//  ITunesSearchApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import UIKit
import RxSwift

class ItunesContentViewController: BaseViewController {
    
    private var tableView: UITableView!
    private var searchTextField: UITextField!
    var searchTimer: Timer?
    
    let viewModel: ItunesContentViewModel = ItunesContentViewModel()
    
    let PADDING: CGFloat = 8
    let TEXTFIELD_HEIGHT: CGFloat = 60
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureTextField()
        
        configureTableView()
        
        getItunesContentsData(searchText: "Jack+johnson")
        
        
    }
    
    func configureTextField(){
        searchTextField = .init()
        searchTextField.placeholder = "Search ITunes Content"
        searchTextField.borderWidth = 0.5
        searchTextField.borderColor = .lightGray
        searchTextField.setLeftPaddingPoints(PADDING)
        searchTextField.setRightPaddingPoints(PADDING)
        let searchTextFieldMarginGuide = searchTextField.layoutMarginsGuide
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchTextField)
        
        searchTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 2*PADDING).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -2*PADDING).isActive = true
        searchTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5*PADDING).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: TEXTFIELD_HEIGHT).isActive = true
        
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func configureTableView(){
        tableView = .init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItunesContentTableViewCell.self, forCellReuseIdentifier: ItunesContentTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: searchTextField,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 2*PADDING).isActive = true
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        stopSearchTimer()
        startSearchTimer()
        
        
        //    viewModel.filterAttendee(filterText: textField.text ?? "", index: viewModel.currentCampaignIndex)
        //
        //    self.tableView.reloadData()
    }
    
    func startSearchTimer(){
        guard searchTimer == nil else { return }
        
        searchTimer =  Timer.scheduledTimer(
            timeInterval: TimeInterval(1.0),
            target      : self,
            selector    : #selector(search),
            userInfo    : nil,
            repeats     : false
        )
        
    }
    
    func stopSearchTimer(){
        searchTimer?.invalidate()
        searchTimer = nil
    }
    
    @objc func search(){
        getItunesContentsData(searchText: searchTextField.text ?? "")
    }
    
    func getItunesContentsData(searchText: String){
        viewModel.getSearchContent(searchText: searchText)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let `self` = self else { return }
                self.tableView.reloadData()
                
                }, onError: { [weak self] error in
                    print(error.localizedDescription)
                    
            }).disposed(by: disposeBag)
        
    }
    
    
}

extension ItunesContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itunesContentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:ItunesContentTableViewCell.reuseIdentifier, for: indexPath) as! ItunesContentTableViewCell
        let cellViewModel = viewModel.getItunesContentTableViewCellViewModel(with: indexPath.row)
        
        cell.configure(with: cellViewModel, index: indexPath.row)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController: ItunesContentDetailViewController = .init()
        detailViewController.viewModel = ItunesContentDetailViewModel(selectedItunesContent: viewModel.getItunesContent(at: indexPath.row))
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
}
