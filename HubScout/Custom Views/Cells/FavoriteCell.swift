//
//  FavoriteCell.swift
//  HubScout
//
//  Created by o9tech on 07/08/2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID = "FavoriteCell"
    let avatarImageView = HSAvatarImageView(frame: .zero)
    let usernamaLabel = HSTitleLabel(textAlignment: .left, fontSize: 26)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func set(favorite: Follower) {
        usernamaLabel.text = favorite.login
        avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
    }


    func configure() {
        addSubviews(avatarImageView, usernamaLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),

            usernamaLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernamaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernamaLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernamaLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
