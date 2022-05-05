//
//  ChatViewController.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import UIKit

class ChatViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet weak var chatTXTBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var chatTXT: UITextField!
    
    var viewModel: ChatViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = viewModel?.friend?.name
        setUpInitializers()
        
        chatTable.dataSource = self
        chatTable.rowHeight = UITableView.automaticDimension
        chatTable.estimatedRowHeight = 160
        chatTable.separatorStyle = .none
        for cell in [LeftChatTableViewCell.self, RightChatTableViewCell.self] {
            chatTable.register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    
    /**
     Method to initialize `ChatViewController`
     */
    class func controller(friend: Friend?) -> ChatViewController? {
        let controller = ChatViewController()
        controller.viewModel = ChatViewModel(friend: friend)
        return controller
    }
}

extension ChatViewController: KeyBoardNotifierDelegate, UITableViewDataSource {
    // MARK: - Custom Accessors
    
    fileprivate func setUpInitializers() {
        KeyboardNotifier.shared.registerforKeyBoardNotification(delegate: self)
        addOnTapDismissKeyboard()
    }
    
    fileprivate func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: (self.viewModel?.chats.count)! - 1, section: 0)
            self.chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    fileprivate func addOnTapDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    fileprivate func addChat() {
        viewModel?.addNewChat(newchat: chatTXT.text, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.chatTXT.text = ""
                self?.didNewChatMessagesRecieved()
            }
        })
    }
    
    // MARK: - ChatViewControllerDelegate
    
    func didNewChatMessagesRecieved() {
        chatTable.reloadData()
        scrollToBottom()
    }
    
    // MARK: - KeyBoardNotificationDelegate
    
    func didKeyBoardAppeared(keyboardHeight: CGFloat) {
        self.chatTXTBottomConstraint.constant = (keyboardHeight == 0) ? 0 : keyboardHeight - 20
        chatTable.reloadData()
        scrollToBottom()
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let chat = viewModel?.chats[indexPath.row]
        switch indexPath.row % 2 {
        case 0:
            if let rightChatCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RightChatTableViewCell.self)) as? RightChatTableViewCell {
                rightChatCell.userLabel.text = "Me"
                rightChatCell.chatLabel.text = chat?.chatMessage
                cell = rightChatCell
            }
        default:
            if let leftChatCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeftChatTableViewCell.self)) as? LeftChatTableViewCell {
                leftChatCell.userLabel.text = viewModel?.friend?.name?.capitalized
                leftChatCell.chatLabel.text = chat?.chatMessage
                cell = leftChatCell
            }
        }
        
        return cell
    }
    
    // MARK: - IBAction
    
    @IBAction func sendChat(_ sender: UIButton) {
        (chatTXT.text?.isEmpty)! ? nil : addChat()
    }
}
