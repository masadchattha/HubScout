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

class FollowerListVC: HSDataLoadingVC {

    var username: String!
    private var followers: [Follower]         = []
    private var filteredFollowers: [Follower] = []
    var page                                  = 1
    var hasMoreFollowers                      = true
    var isSearching: Bool                     = false
    var isLoadingMoreFollowers                = false

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

        let addBarButton                  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
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
        searchController.searchBar.placeholder  = "Search for a username"
        navigationItem.searchController         = searchController
    }
}


// MARK: - Action Methods

private extension FollowerListVC {

    @objc func addButtonTapped() {
        showLoadingView()

        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorite(user: user)
                dismissLoadingView()
            } catch {
                if let hsError = error as? HSError {
                    presentHSAlert(title: "Something went wrong", message: hsError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultErrorAlert()
                }

                dismissLoadingView()
            }
        }
    }


    func addUserToFavorite(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self else { return }

            guard let error else {
                DispatchQueue.main.async { self.presentHSAlert(title: "Success!", message: "You've successfully favorited this user 🎉", buttonTitle: "Hooray!") }
                return
            }

            DispatchQueue.main.async { self.presentHSAlert(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok") }
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
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
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
        isLoadingMoreFollowers = true

        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
                isLoadingMoreFollowers = false
            } catch {
                if let hsError = error as? HSError {
                    presentHSAlert(title: "Bad Stuff Happend", message: hsError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultErrorAlert()
                }

                dismissLoadingView()
                isLoadingMoreFollowers = false
            }
        }
    }


    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)

        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀"
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }

        self.updateDate(on: self.followers)
    }
}


// MARK: - UISearchResultsUpdating

extension FollowerListVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, filter.isNotEmpty else {
            filteredFollowers.removeAll()
            updateDate(on: followers)
            isSearching = false
            return
        }

        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateDate(on: filteredFollowers)
    }
}


// MARK: - FollowerListVCDelegate

extension FollowerListVC: UserInfoVCDelegate {

    func didRequestFollowers(for username: String) {
        self.username = username
        title         = username
        page          = 1

        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
