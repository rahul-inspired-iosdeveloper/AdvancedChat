//
//  Chat.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import Foundation

class Chat {
    // MARK: - Properties

    var chatUser: String?
    var chatUser_Pic: String? // Profile pic
    var chatMessage: String?

    init(arg_user: String, arg_pic: String, arg_message: String) {
        chatUser = arg_user
        chatUser_Pic = arg_pic
        chatMessage = arg_message
    }
}
