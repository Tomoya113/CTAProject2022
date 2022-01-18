//
//  SearchShopsTableViewCell.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/18.
//

import UIKit
import SnapKit

class SearchShopsTableViewCell: UITableViewCell {
    var shopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var shopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 24
        return stackView
    }()
    
    var containerStackView: UIStackView = {
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

//MARK: Static Methods
extension SearchShopsTableViewCell {
    static var reuseIdentifier = "cell"
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
