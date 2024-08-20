//
//  FollowerCell.swift
//  HubScout
//
//  Created by o9tech on 23/07/2024.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {

    static let reuseID  = "FollowerCell"


    func set(follower: Follower) {
        contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
    }
}
