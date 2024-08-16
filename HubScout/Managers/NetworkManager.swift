//
//  NetworkManager.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 23/07/2024.
//

import UIKit

class NetworkManager {

    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    let decoder         = JSONDecoder()


    private init() {
        decoder.keyDecodingStrategy  = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }


    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], HSError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let followers = try self.decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }


    func getFollowers(for username: String, page: Int) async throws ->  [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else { throw HSError.invalidUsername }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw HSError.invalidResponse }

        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw HSError.invalidData
        }
    }


    func getUserInfo(for username: String, completed: @escaping (Result<User, HSError>) -> Void) {
        let endpoint = baseURL + "\(username)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let user = try self.decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }


    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
}
