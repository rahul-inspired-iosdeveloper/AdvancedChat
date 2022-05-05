//
//  Friend.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import Foundation

class Friend {
    
    //MARK:- Properties
    var name: String?
    var lastMessage: String?
    var messages: [Chat]?
    
    internal init(name: String? = nil, lastMessage: String? = nil) {
        self.name = name
        self.lastMessage = lastMessage
    }
}
