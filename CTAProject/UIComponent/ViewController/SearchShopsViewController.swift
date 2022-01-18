//
//  SearchShopsViewController.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/12.
//

import UIKit
import SnapKit

final class SearchShopsViewController: UIViewController {
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.register(SearchShopsTableViewCell.self, forCellReuseIdentifier: SearchShopsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.placeholder = "キーワード"
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setDelegates()
    }
  
    //NOTE: navigationBarを参照する必要があるので、viewDidAppearでAutoLayoutの設定を呼んでいます
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeConstraints()
    }
    
}

//MARK: TableView Configuration
extension SearchShopsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchShopsTableViewCell.reuseIdentifier, for: indexPath) as! SearchShopsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
}

//MARK: UI Configuration
extension SearchShopsViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        navigationItem.title = "グルスポ"
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: AutoLayout Configuration
extension SearchShopsViewController {
    private func makeConstraints() {
        searchBar.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.height.equalTo(64)
            if let navigationBar = navigationController?.navigationBar {
                make.top.equalTo(navigationBar.snp.bottom)
            } else {
                make.top.equalTo(view.snp.top)
            }
        }
        tableView.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
