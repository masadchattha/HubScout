//
//  UserInfoVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 31/07/2024.
//

import UIKit

class UserInfoVC: UIViewController {

    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    var itemViews: [UIView] = []

    var username: String!


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
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
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
                    self.add(childVC: HSRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: HSFollowerItemVC(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

