//
//  HSRepoItemVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 05/08/2024.
//

import UIKit

class HSFollowerItemVC: HSItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }


    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgrounColor: .systemGreen, title: "Get Followers")
    }


    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
