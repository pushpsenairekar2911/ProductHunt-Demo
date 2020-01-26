//
//  ProductCell.swift
//  Created by Pushpsen Airekar on 26/1/20.
//  Copyright © 2020 Pushpsen Airekar. All rights reserved.
//

// MARK: - Importing Frameworks.

import UIKit

/* ----------------------------------------------------------------------------------- */


class ProductCell: UITableViewCell {
   
    // MARK: - Declaration of IBOutlet
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var count: UILabel!
    
    // MARK: - Declaration of Variables
    
    var  post : Post! {
        didSet{
            self.title.text = post.title
            self.message.text = post.message
            self.count.text = "\(post.count)"
            let url = URL(string: post.imageURL)
            icon.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
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


