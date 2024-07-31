//
//  User.swift
//  HubScout
//
//  Created by o9tech on 22/07/2024.
//

import Foundation

class User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
