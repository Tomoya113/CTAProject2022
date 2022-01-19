//
//  SearchShopsTableViewCell.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/18.
//

import UIKit
import SnapKit

final class SearchShopsTableViewCell: UITableViewCell {
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
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        shopNameLabel.text = "テキストテキストテキストテキストテキスト"
        priceLabel.text = "テキストテキストテキストテキストテキスト"
        locationLabel.text = "テキストテキストテキストテキストテキスト"
        shopImageView.image = UIImage(systemName: "bag")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: UI Configuration
extension SearchShopsTableViewCell {
    private func setupView() {
        addSubview(containerStackView)
        labelStackView.addArrangedSubview(shopNameLabel)
        labelStackView.addArrangedSubview(priceLabel)
        labelStackView.addArrangedSubview(locationLabel)
        containerStackView.addArrangedSubview(shopImageView)
        containerStackView.addArrangedSubview(labelStackView)
    }
}

//MARK: AutoLayout Configuration
extension SearchShopsTableViewCell {
    private func makeConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
        }
        shopImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
}
