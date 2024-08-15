//
//  HSRepoItemVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 05/08/2024.
//

import UIKit

protocol HSFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class HSFollowerItemVC: HSItemInfoVC {

    weak var delegate: HSFollowerItemVCDelegate!


    init(user: User, delegate: HSFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


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
