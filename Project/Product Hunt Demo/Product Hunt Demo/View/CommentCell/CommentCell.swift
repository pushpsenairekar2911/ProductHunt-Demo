//
//  CommentCell.swift
//  Created by Pushpsen Airekar on 26/1/20.
//  Copyright © 2020 Pushpsen Airekar. All rights reserved.
//
// MARK: - Importing Frameworks.

import UIKit

/* ----------------------------------------------------------------------------------- */

class CommentCell: UITableViewCell {

    // MARK: - Declaration of IBOutlet
       
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cardView: UIView!
    
     // MARK: - Declaration of Variables
    
    var comment: Comment! {
        didSet {
            name.text = comment.name
            profession.text = comment.profession
            message.text = comment.comment
            time.text = comment.time
            let url = URL(string: comment.avatar)
            avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "defaultAvatar"))
        }
    }
    
    // MARK: - Initialization of required Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        cardView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


/* ----------------------------------------------------------------------------------- */
