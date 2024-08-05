//
//  HSItemInfoVC.swift
//  HubScout
//
//  Created by o9tech on 05/08/2024.
//

import UIKit

class HSItemInfoVC: UIViewController {

    let stackView       = UIStackView()
    let itemInfoViewOne = HSItemInfoView()
    let itemInfoViewTwo = HSItemInfoView()
    let actionButton    = HSButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
    }


    private func configureBackgroundView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 16
    }


    private func configureStackView() {
        stackView.axis    = .horizontal
        stackView.spacing = 16
    }


    private func layoutUI() {
        
    }
}
