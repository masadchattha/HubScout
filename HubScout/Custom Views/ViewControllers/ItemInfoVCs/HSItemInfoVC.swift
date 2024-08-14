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
    let actionButton    = HSButton()

    var user: User!
    weak var delegate: UserInfoVCDelegate!

    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        configureActionButton()
        layoutUI()
    }


    private func configureBackgroundView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 16
    }


    private func configureStackView() {
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }


    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }


    @objc func actionButtonTapped() { }


    private func layoutUI() {
        view.addSubviews(stackView, actionButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
