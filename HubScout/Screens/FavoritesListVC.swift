//
//  FavoritesListVC.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 16/07/2024.
//

import UIKit

class FavoritesListVC: HSDataLoadingVC {

    let tableView             = UITableView()
    var favorites: [Follower] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }


    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }


    func configureTableView() {
        view.addSubview(tableView)

        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate   = self
        tableView.dataSource = self

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }


    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)

            case .failure(let error):
                self.presentHSAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }


    func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: "No Favorites?\n\nAdd one on the follower screen.", in: self.view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite           = favorites[indexPath.row]
        let destVC             = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }

            self.presentHSAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
