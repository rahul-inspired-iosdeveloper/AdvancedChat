//
//  MyFriendsViewModel.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import Foundation

class MyFriendsViewModel {
    // MARK: - Properties

    var friendsList: [Friend]?

    // MARK: - Initializer

    init() {
        friendsList = [Friend(name: "Jone", lastMessage: "How are you?"), Friend(name: "Kent", lastMessage: "Hello")]
    }

    // MARK: - Custom Accessors

    func getFriendsList() -> [Friend]? {
        return friendsList
    }
}
