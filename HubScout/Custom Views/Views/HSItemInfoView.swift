//
//  HSItemInfoView.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 02/08/2024.
//

import UIKit

enum ItemInfoType {
    case repos, gists, following, followers
}


class HSItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel      = HSTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = HSTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label

        NSLayoutConstraint.activate([
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }


    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text       = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text       = "Public Gists"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text       = "Following"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text       = "Followers"
        }

        countLabel.text = String(count)
    }
}
