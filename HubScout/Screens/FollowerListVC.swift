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
    }
}
