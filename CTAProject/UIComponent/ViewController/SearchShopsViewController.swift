//
//  SearchShopsViewController.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/12.
//

import Moya
import PKHUD
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class SearchShopsViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let viewModel: SearchShopsViewModel = {
        let provider = MoyaProvider<MultiTarget>()
        let viewModel = SearchShopsViewModel(
            model: SearchShopsModel(provider: provider)
        )
        return viewModel
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = Const.TableViewCell.height
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

        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [searchBar] _ in
                searchBar.resignFirstResponder()
                searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)

        let searchBarText = searchBar.rx.textDidEndEditing
            .withLatestFrom(searchBar.rx.text.orEmpty.asObservable())
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: "")

        searchBarText
            .drive(onNext: { [searchBar] _ in
                searchBar.text = ""
            })
            .disposed(by: disposeBag)

        // NOTE: 普通に文字が流れてきた時
        searchBarText
            .filter { $0.count < 50 }
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.viewModel.inputs.keyword.onNext(text)
            })
            .disposed(by: disposeBag)

        // NOTE: 50文字以上
        searchBarText
            .filter { $0.count > 50 }
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.view.addSubview(SearchShopsAlertModal())
            })
            .disposed(by: disposeBag)

        viewModel.outputs.shops
            .asObservable()
            .bind(to: tableView.rx.items(
                cellIdentifier: SearchShopsTableViewCell.reuseIdentifier,
                cellType: SearchShopsTableViewCell.self)
            ) { index, shop, cell in
                cell.configureCell(
                    shopName: shop.name,
                    locationName: shop.stationName,
                    price: shop.budget.name,
                    shopImageURL: shop.logoImage
                )
            }
            .disposed(by: disposeBag)

        viewModel.outputs.loading
            .drive(onNext: { result in
                result ? HUD.show(.progress) : HUD.hide()
            })
            .disposed(by: disposeBag)

    }
    // NOTE: navigationBarを参照する必要があるので、viewDidAppearでAutoLayoutの設定を呼んでいます
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeConstraints()
    }

}

//MARK: Constants
extension SearchShopsViewController {
    enum Const {
        enum SearchBar {
            static let height = 64
            static let maxWordCount = 50
        }

        enum TableViewCell {
            static let height: CGFloat = 192
        }
    }
}

// MARK: UI Configuration
extension SearchShopsViewController {
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        navigationItem.title = L10n.searchShopsNavigationBarTitle
    }

}

// MARK: AutoLayout Configuration
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
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
}
