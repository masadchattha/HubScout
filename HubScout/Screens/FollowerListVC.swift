//
//  FollowerListVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchFolowers()
    }
}


// MARK: - Networking Methods

private extension FollowerListVC {

    func fetchFolowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in

            switch result {
            case .success(let followers):
                print(followers)

            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

