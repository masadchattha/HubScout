//
//  HSRepoItemVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 05/08/2024.
//

import UIKit

protocol HSRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class HSRepoItemVC: HSItemInfoVC {

    weak var delegate: HSRepoItemVCDelegate!


    init(user: User, delegate: HSRepoItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person")
    }


    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
