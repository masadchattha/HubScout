//
//  FollowerListVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var collectionView: UICollectionView!
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        fetchFolowers()
    }
}


// MARK: - UI configuration Methods

extension FollowerListVC {

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }


    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }


    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3

        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
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

