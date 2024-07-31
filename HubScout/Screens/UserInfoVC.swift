//
//  UserInfoVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 31/07/2024.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        getUserInfo(for: username)
    }


    func configureNavBar() {
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBarButton
    }


    @objc func dismissVC() {
        dismiss(animated: true)
    }


    func getUserInfo(for username: String) {
        guard username.isNotBlank else { return }
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                dump(user)
            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
