//
//  HSBodyLabel.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit

class HSBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }


    func configure() {
        textColor                         = .secondaryLabel
        font                              = .preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth         = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
