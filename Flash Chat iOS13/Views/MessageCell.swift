//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by MAHFUJ on 5/1/23.
//  Copyright © 2023 MAHFUJ. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessageCell: UITableViewCell {
    
    //cause + Type = textLab
    //userPictureImageView
    
    @IBOutlet private weak var messageBubble: UIView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var avaterView: UIImageView!
    @IBOutlet private weak var youAvaterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height/5 // round the corners on messageBubbles height
    }
    
    
    func reload(message: Message) {
        label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            youAvaterView.isHidden = false
            avaterView.isHidden = true
            youAvaterView.tintColor = .systemBlue
            label.textColor = UIColor.white
            messageBubble.backgroundColor = UIColor(named: "BrandBlue")
        } else {
            youAvaterView.isHidden = true
            avaterView.isHidden = false
            avaterView.tintColor = UIColor.darkGray
            label.textColor = UIColor.white
            messageBubble.backgroundColor = UIColor.blue
        }
    }
    
}
