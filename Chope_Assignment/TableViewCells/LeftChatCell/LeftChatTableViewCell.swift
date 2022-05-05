//
//  LeftChatTableViewCell.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import UIKit

class LeftChatTableViewCell: UITableViewCell {

    //MARK:- Properties
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
