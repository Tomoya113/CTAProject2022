//
//  SearchShopsTableViewCell.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/18.
//

import Nuke
import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit

final class SearchShopsTableViewCell: UITableViewCell {
    var didTapFavoriteButton: Signal<Void> {
        favoriteButton.rx.tap.asSignal()
    }
    var disposeBag = DisposeBag()

    private let shopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let shopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 24
        return stackView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: L10n.systemStar), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        refreshDisposeBag()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func refreshDisposeBag() {
        disposeBag = DisposeBag()
    }
}


// MARK: UI Configuration
extension SearchShopsTableViewCell {
    private func setupView() {
        contentView.addSubview(containerStackView)
        labelStackView.addArrangedSubview(shopNameLabel)
        labelStackView.addArrangedSubview(priceLabel)
        labelStackView.addArrangedSubview(locationLabel)
        containerStackView.addArrangedSubview(shopImageView)
        containerStackView.addArrangedSubview(labelStackView)
        containerStackView.addArrangedSubview(favoriteButton)
    }

    fileprivate func configureCell(_ data: SearchShopsTableViewCellData) {
        shopNameLabel.text = data.shopName
        locationLabel.text = data.locationName
        priceLabel.text = data.price
        Nuke.loadImage(with: data.shopImageURL, into: shopImageView)
        handleFavoriteButtonAppearance(data.favorited)
    }

    private func handleFavoriteButtonAppearance(_ favorited: Bool) {
        if favorited {
            favoriteButton.tintColor = .systemYellow
            favoriteButton.setImage(UIImage(systemName: L10n.systemStarFill), for: .normal)
        } else {
            favoriteButton.tintColor = .gray
            favoriteButton.setImage(UIImage(systemName: L10n.systemStar), for: .normal)
        }
    }
}


// MARK: AutoLayout Configuration
extension SearchShopsTableViewCell {
    private func makeConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(snp.edges).inset(UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
            make.center.equalTo(snp.center)
        }
        shopImageView.snp.makeConstraints { make in
            make.width.equalTo(144)
            make.height.equalTo(144)
        }
        favoriteButton.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
    }
}

extension Reactive where Base: SearchShopsTableViewCell {
    var bindCellData: Binder<SearchShopsTableViewCellData> {
        return Binder(self.base) { view, data in
            view.configureCell(data)
        }
    }
}
