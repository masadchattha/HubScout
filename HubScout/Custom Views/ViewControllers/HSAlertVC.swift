//
//  HSAlert.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit

class HSAlertVC: UIViewController {

    let containerView = HSAlertContainerView()
    let containerStackView = UIStackView()
    let titleLabel = HSTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = HSBodyLabel(textAlignment: .center)
    let actionButton = HSButton(color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?

    let padding: CGFloat = 20


    init(alertTitle: String?, message: String?, buttonTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = alertTitle
        self.message        = message
        self.buttonTitle    = buttonTitle
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        configureContainerView()
        configureContainerStackView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
    }
}


// MARK: - UI Configuration

private extension HSAlertVC {

    func configureContainerView() {
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


    func configureContainerStackView() {
        containerView.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis     = .vertical
        containerStackView.spacing  = 16

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            containerStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            containerStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }


    func configureTitleLabel() {
        containerStackView.addArrangedSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
    }


    func configureMessageLabel() {
        containerStackView.addArrangedSubview(messageLabel)
        messageLabel.text          = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 0
    }


    func configureActionButton() {
        containerStackView.addArrangedSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}


// MARK: - Action Methods

extension HSAlertVC {

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
