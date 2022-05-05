//
//  ChatViewModel.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import Foundation

class ChatViewModel {
    // MARK: - Properties

    var friend: Friend?
    var chats: [Chat] = []

    // MARK: - Initializer

    init(friend: Friend?) {
        self.friend = friend

        initializeChatData(friend)
    }
}

extension ChatViewModel {
    fileprivate func initializeChatData(_ friend: Friend?) {
        if let messages = friend?.messages {
            chats = messages
        } else {
            let chat1 = Chat(arg_user: "", arg_pic: "", arg_message: friend?.lastMessage ?? "")
            let chat2 = Chat(arg_user: "", arg_pic: "", arg_message: friend?.lastMessage ?? "")
            self.chats.append(contentsOf: [chat1, chat2])
        }
    }

    func addNewChat(newchat: String?, completion: @escaping (() -> Void)) {
        friend?.lastMessage = newchat
        chats.append(Chat(arg_user: "", arg_pic: "", arg_message: newchat ?? ""))
        chats.append(Chat(arg_user: "", arg_pic: "", arg_message: newchat ?? ""))
        friend?.messages = chats
        completion()
    }
}
