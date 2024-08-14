//
//  UserDefaultsManager.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 06/08/2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {

    enum Keys {
        static let favorites = "FavoritesKey"
    }

    private static let defaults = UserDefaults.standard


    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (HSError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }

                    favorites.append(favorite)

                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }

                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }
        }
        
    }


    static func retrieveFavorites(completed: @escaping (Result<[Follower], HSError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.invalidData))
        }
    }


    static func save(favorites: [Follower]) -> HSError? {
        do {
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defaults.set(encoderFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
