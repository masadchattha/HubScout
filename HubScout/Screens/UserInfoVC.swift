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
        print("Username: ", username)
    }


    func configureNavBar() {
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBarButton
    }


    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
