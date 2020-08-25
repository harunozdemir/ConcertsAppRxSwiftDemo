//
//  ConcertListViewController.swift
//  ConcertsApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import UIKit
import RxSwift

class ConcertListViewController: BaseViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private let cellID = "ConcertListItemTableViewCell"
  
  let viewModel: ConcertListViewModel = ConcertListViewModel()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    
    getConcertsData()
    
    
  }
  
  func configureTableView(){
    tableView.dataSource = self
    //tableView.delegate = self
    
    tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
  }
  
  
  func getConcertsData(){
    
    viewModel.getConcerts()
    .observeOn(MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] response in
        guard let `self` = self else { return }
        self.tableView.reloadData()
        
      }, onError: { [weak self] error in
        
      }).disposed(by: disposeBag)
  
   
    //
    //    guard let url = URL(string: jsonUrlString) else {
    //      return
    //    }
    //
    //    URLSession.shared.dataTask(with: url) {(data, response, err) in
    //
    //      guard let data = data else {
    //        return
    //      }
    //
    //      do {
    //
    //        if let concertsResponse = try? JSONDecoder().decode(ConcertResponse.self, from: data) {
    //          DispatchQueue.main.async {
    //
    //            if concertsResponse.concerts.count > 0 {
    //                self.viewModel.concerts = concertsResponse.concerts
    //                self.tableView.reloadData()
    //            }
    //          }
    //        }
    //
    //
    //
    //      } catch let jsonErr {
    //        print(jsonErr.localizedDescription)
    //
    //      }
    //
    //
    //      }.resume()
    
  }
  
  
}

extension ConcertListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.concertCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! ConcertListItemTableViewCell
    let cellViewModel = viewModel.getConcertTableViewCellViewModel(with: indexPath.row)
    
    cell.configure(with: cellViewModel, index: indexPath.row)
    
    
    return cell
  }
  
}
