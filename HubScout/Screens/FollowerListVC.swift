//
//  FollowerListVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit


// MARK: - protocols

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}


// MARK: - Enums

private extension FollowerListVC {
    enum Section { case main }
}


// MARK: - FollowerListVC

class FollowerListVC: HSDataLoadingVC {

    var username: String!
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching: Bool = false

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!


    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title         = username
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
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

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addBarButton
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


    func configureSearchController() {
        let searchController                    = UISearchController()
        searchController.searchResultsUpdater   = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Search for a username"
        navigationItem.searchController         = searchController
    }
}


// MARK: - Action Methods

private extension FollowerListVC {

    @objc func addButtonTapped() {
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self else { return }

                    guard let error else {
                        self.presentHSAlertOnMainThread(title: "Success!", message: "You've successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }

                    self.presentHSAlertOnMainThread(title: "Unable to favorite", message: error.rawValue, buttonTitle: "Ok")
                }

            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
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


    func updateDate(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot) //  default 'animatingDifferences' is true
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


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray        = isSearching ? filteredFollowers : followers
        let follower           = activeArray[indexPath.item]

        let destVC             = UserInfoVC()
        destVC.username        = follower.login
        destVC.delegate        = self
        let navController      = UINavigationController(rootViewController: destVC)
        present(navController , animated: true)
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

                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }

                self.updateDate(on: self.followers)

            case .failure(let error):
                self.presentHSAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


// MARK: - UISearchResultsUpdating

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, filter.isNotEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateDate(on: filteredFollowers)
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateDate(on: followers)
    }
}


// MARK: - FollowerListVCDelegate

extension FollowerListVC: FollowerListVCDelegate {

    func didRequestFollowers(for username: String) {
        self.username = username
        title         = username
        page          = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}
