//
//  SearchVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 16/07/2024.
//

import UIKit

private extension SearchVC {

    enum Constant {
        static let emptyUsernameErrorTitle       = "Empty Username"
        static let emptyUsernameErrorDescription = "Please enter a username. We need to know who to look for 😃."
    }
}

class SearchVC: UIViewController {

    typealias Alert        = (title: String, action: () -> Void)

    let logoImageView      = UIImageView()
    let usernameTextField  = HSTextField()
    let callToActionButton = HSButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")

    var isUsernameEntered: Bool { usernameTextField.text!.isNotBlank }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)

        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}


// MARK: - UI Configuration Methods

private extension SearchVC {

    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo

        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }


    func configureTextField() {
        usernameTextField.delegate = self

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


// MARK: - Navigation Method


private extension SearchVC {

    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentHSAlert(title: Constant.emptyUsernameErrorTitle, message: Constant.emptyUsernameErrorDescription, buttonTitle: "OK")
            return
        }
 
        usernameTextField.resignFirstResponder()

        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}


// MARK: - GestureRecognizer Methods

extension SearchVC {

    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}


// MARK: - UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

