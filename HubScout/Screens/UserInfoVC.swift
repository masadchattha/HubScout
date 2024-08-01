//
//  UserInfoVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 31/07/2024.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    let headerView = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureVC()
        layoutUI()
        getUserInfo()
    }
}


// MARK: - Action Methods

extension UserInfoVC {

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


// MARK: - Setup Methods

private extension UserInfoVC {

    func configureVC() {
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBarButton
    }


    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }


    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}


// MARK: - Netwroking Methods

private extension UserInfoVC {

    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: HSUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

