//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Mahmoud on 6/22/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    //MARK:- Properties

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var meView: UIView!
    @IBOutlet weak var youView:UIView!
    @IBOutlet weak var messageCont: UILabel!
    //MARK:- Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        meView.layer.cornerRadius       = 0.5 * meView.bounds.size.width
        youView.layer.cornerRadius      = 0.5 * youView.bounds.size.width
        bubbleView.layer.cornerRadius   = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
