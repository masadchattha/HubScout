//
//  HSAlertContainerView.swift
//  HubScout
//
//  Created by o9tech on 13/08/2024.
//

import UIKit

class HSAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        backgroundColor    = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
