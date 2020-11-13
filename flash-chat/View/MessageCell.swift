//
//  MessageCell.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/12/20.
//

import UIKit

class MessageCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }
    
    //MARK: - Functions
    func setupMessageCell(fromMe: Bool, message: String) {
        leftImageView.isHidden = fromMe
        rightImageView.isHidden = !fromMe
        messageBubble.backgroundColor = UIColor(named: fromMe ? K.BrandColors.purple : K.BrandColors.lightPurple)
        label.textColor = UIColor(named: fromMe ? K.BrandColors.lightPurple : K.BrandColors.purple)
        label.text = message
    }
    
}
