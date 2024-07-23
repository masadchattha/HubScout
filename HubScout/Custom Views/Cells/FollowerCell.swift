//
//  FollowerCell.swift
//  HubScout
//
//  Created by o9tech on 23/07/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    let avatarImageView = HSAvatarImageView(frame: .zero)
    let usernamaLabel = HSTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follwer: Follower) {
        usernamaLabel.text = follwer.login
    }

    func configure() {
        let padding: CGFloat = 8
        addSubview(avatarImageView)
        addSubview(usernamaLabel)
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            usernamaLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernamaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernamaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernamaLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
