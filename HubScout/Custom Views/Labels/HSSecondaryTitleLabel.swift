//
//  HSSecondaryTitleLabel.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 01/08/2024.
//

import UIKit

class HSSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = .systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }


    func configure() {
        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
