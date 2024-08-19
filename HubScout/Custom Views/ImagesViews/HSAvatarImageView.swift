//
//  HSAvatarImageView.swift
//  HubScout
//
//  Created by o9tech on 23/07/2024.
//

import UIKit

class HSAvatarImageView: UIImageView {

    let placeholderImage = Images.placeholder
    let cache = NetworkManager.shared.cache


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }


    func downloadImage(fromURL url: String) {
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
}
