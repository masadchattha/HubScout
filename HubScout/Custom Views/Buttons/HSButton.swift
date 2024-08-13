//
//  HSButton.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 16/07/2024.
//

import UIKit

class HSButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    convenience init(backgrounColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgrounColor
        self.setTitle(title, for: .normal)
    }


    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = .preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }


    func set(backgrounColor: UIColor, title: String) {
        self.backgroundColor = backgrounColor
        setTitle(title, for: .normal)
    }
}
