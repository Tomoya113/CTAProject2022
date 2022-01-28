//
//  SearchShopsViewController.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/12.
//

import UIKit
import SnapKit

final class SearchShopsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.register(SearchShopsTableViewCell.self, forCellReuseIdentifier: SearchShopsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = L10n.searchShopsSearchBarPlaceholder
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

//MARK: Constants
extension SearchShopsViewController {
    struct Const {
        struct SearchBar {
            static let height = 64
            static let maxWordCount = 50
        }
        
        struct TableViewCell {
            static let height: CGFloat = 192
        }
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
        return Const.TableViewCell.height
    }
}

//MARK: SearchBar Configuration
extension SearchShopsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchBarText = searchBar.text else {
            return
        }
        
        guard searchBarText.count <= Const.SearchBar.maxWordCount else {
            view.addSubview(SearchShopsAlertModal())
            searchBar.text = ""
            return
        }
        
        //TODO: 店の情報を取得する
    }
    
}

//MARK: UI Configuration
extension SearchShopsViewController {
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        navigationItem.title = L10n.searchShopsNavigationBarTitle
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

//MARK: AutoLayout Configuration
extension SearchShopsViewController {
    private func makeConstraints() {
        searchBar.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.height.equalTo(Const.SearchBar.height)
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
