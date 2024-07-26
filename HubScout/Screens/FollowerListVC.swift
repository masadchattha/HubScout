//
//  FollowerListVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit


// MARK: - Enums

private extension FollowerListVC {
    enum Section { case main }
}


// MARK: - FollowerListVC

class FollowerListVC: UIViewController {

    var username: String!
    private var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
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


// MARK: - CollectionView Helper Methods

private extension FollowerListVC {

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }


    func updateDate() {
        var snapshop = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshop.appendSections([.main])
        snapshop.appendItems(followers)
        dataSource.apply(snapshop) //  default 'animatingDifferences' is true
    }
}


// MARK: - UICollectionViewDelegate

extension FollowerListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height

        if offsetY > (contentHeight - height) { // Scrolled to the bottom of screen
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}


// MARK: - Networking Methods

private extension FollowerListVC {

    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self else { return }
            dismissLoadingView() 

            switch result {
            case .success(let followers):
                if followers.count < 100 { hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateDate()

            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

