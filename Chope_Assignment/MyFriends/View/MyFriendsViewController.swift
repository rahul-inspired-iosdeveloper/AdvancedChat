//
//  ViewController.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import UIKit

class MyFriendsViewController: UIViewController {

    //MARK:- Properties
    @IBOutlet weak var myFriendsListTableView: UITableView!
    
    var viewModel: MyFriendsViewModel?
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My friends"
        
        myFriendsListTableView.dataSource = self
        myFriendsListTableView.delegate = self
        myFriendsListTableView.rowHeight = UITableView.automaticDimension
        myFriendsListTableView.estimatedRowHeight = 160
        myFriendsListTableView.separatorStyle = .none
        myFriendsListTableView.register(UINib(nibName: String(describing: UserChatTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UserChatTableViewCell.self))
        
        viewModel = MyFriendsViewModel.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        myFriendsListTableView.reloadData()
    }
}

extension MyFriendsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getFriendsList()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let userChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserChatTableViewCell.self), for: indexPath) as? UserChatTableViewCell {
            let friend = viewModel?.getFriendsList()?[indexPath.row]
            userChatTableViewCell.userNameLabel.text = friend?.name
            userChatTableViewCell.chatLabel.text = friend?.lastMessage
            switch indexPath.row % 2
            {
                
            case 0:
                userChatTableViewCell.chatLabelView.backgroundColor = .lightGray
            default:
                userChatTableViewCell.chatLabelView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.5)
            }
            cell = userChatTableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = viewModel?.getFriendsList()?[indexPath.row]
        if let chatView = ChatViewController.controller(friend: friend) {
            navigationController?.pushViewController(chatView, animated: true)
        }
    }
}

