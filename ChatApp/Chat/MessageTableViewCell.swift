//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Mahmoud on 6/22/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageCont: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()

        bubbleView.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
