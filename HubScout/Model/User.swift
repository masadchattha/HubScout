//
//  User.swift
//  HubScout
//
//  Created by o9tech on 22/07/2024.
//

import Foundation

class User: Codable {
    var login: String
    var avatarUrl: String
    var name: String
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
