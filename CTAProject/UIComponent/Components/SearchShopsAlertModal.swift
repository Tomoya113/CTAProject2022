//
//  SearchShopsAlertModal.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/28.
//

import RxSwift
import SnapKit
import UIKit

final class SearchShopsAlertModal: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.baseBackgroundColor.color
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.searchShopsAlertModalLabelText
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Const.TitleLabel.fontSize)
        label.numberOfLines = Const.TitleLabel.numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.searchShopsCloseButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Const.CloseButton.fontSize)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraints()
    }
    
    @objc
    private func dismissModal() {
        removeFromSuperview()
    }
    
}

// MARK: Constants
extension SearchShopsAlertModal {
    enum Const {
        enum ContainerView {
            static let marginLeft = 20
            static let marginRight = -20
            static let heightRatio = 3.5
        }
        
        enum TitleLabel {
            static let fontSize: CGFloat = 20
            static let marginTop = 48
            static let marginRight = -8
            static let marginLeft = 8
            static let numberOfLines = 1
        }
        
        enum CloseButton {
            static let fontSize: CGFloat = 16
            static let marginBottom = -30
            static let size = CGSize(width: 180, height: 48)
        }
        
    }
}

// MARK: UI Configuration
extension SearchShopsAlertModal {
    private func setupView() {
        backgroundColor = Asset.modalOverlay.color
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeButton)
    }
}

// MARK: AutoLayout Configuration
extension SearchShopsAlertModal {
    private func makeConstraints() {
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(snp.height).dividedBy(Const.ContainerView.heightRatio)
            make.left.equalTo(snp.left).offset(Const.ContainerView.marginLeft)
            make.right.equalTo(snp.right).offset(Const.ContainerView.marginRight)
        }
        containerView.layoutIfNeeded()
        containerView.layoutSubviews()
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView).offset(Const.TitleLabel.marginTop)
            make.left.equalTo(containerView.snp.left).offset(Const.TitleLabel.marginLeft)
            make.right.equalTo(containerView.snp.right).offset(Const.TitleLabel.marginRight)
            make.width.equalTo(containerView.snp.width)
        }
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(Const.CloseButton.size)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalTo(containerView).offset(Const.CloseButton.marginBottom)
            make.centerX.equalToSuperview()
        }
    }
}
