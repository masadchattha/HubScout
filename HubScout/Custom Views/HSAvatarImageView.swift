//
//  HSAvatarImageView.swift
//  HubScout
//
//  Created by o9tech on 23/07/2024.
//

import UIKit

class HSAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")!

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


    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self else { return }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self.image = image }
        }

        task.resume()
    }
}
