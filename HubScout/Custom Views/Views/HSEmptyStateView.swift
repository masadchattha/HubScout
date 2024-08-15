//
//  HSEmptyStateView.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 30/07/2024.
//

import UIKit

class HSEmptyStateView: UIView {

    let messageLabel = HSTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }


    func configure() {
        addSubviews(messageLabel, logoImageView)
        configureMessageLabel()
        configureLogoImageVieww()
    }


    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 0
        messageLabel.textColor      = .secondaryLabel

        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        ])
    }


    private func configureLogoImageVieww() {
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        NSLayoutConstraint.activate([
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3)
        ])
    }
}
