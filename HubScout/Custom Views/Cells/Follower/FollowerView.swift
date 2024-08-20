//
//  FollowerView.swift
//  HubScout
//
//  Created by o9tech on 20/08/2024.
//

import SwiftUI

struct FollowerView: View {
    let follower: Follower

    var body: some View {
        VStack {
            avatarImage

            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }


    private var avatarImage: some View {
        AsyncImage(url: URL(string: follower.avatarUrl)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Image(.avatarPlaceholder)
                .resizable()
                .scaledToFit()
        }
        .clipShape(.circle)
    }
}


#Preview {
    FollowerView(follower: Follower(login: "masadchattha", avatarUrl: ""))
}
