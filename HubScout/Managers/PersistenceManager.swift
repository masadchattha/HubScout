//
//  UserDefaultsManager.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 06/08/2024.
//

import Foundation

enum PersistenceActionType {
    case add, rmeove
}


enum PersistenceManager {

    enum Keys {
        static let favorites = "FavoritesKey"
    }

    private static let defaults = UserDefaults.standard


    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (HSError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites

                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }

                    retrievedFavorites.append(favorite)

                case .rmeove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }

                completed(save(favorites: retrievedFavorites))

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
