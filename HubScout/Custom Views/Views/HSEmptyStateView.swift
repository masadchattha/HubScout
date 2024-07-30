//
//  HSEmptyStateView.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 30/07/2024.
//

import UIKit

class HSEmptyStateView: UIView {
    let titleLabel = HSTitleLabel(textAlignment: .left, fontSize: 20)
    let logoImageView = UIImageView(image: .emptyStateLogo)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        configure()
    }


    func configure() {
        addSubview(titleLabel)
        addSubview(logoImageView)

        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        // Label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        // ImageView
        NSLayoutConstraint.activate([
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 48),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: bounds.size.width),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.widthAnchor)
        ])
    }
}
