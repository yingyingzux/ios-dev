//
//  MovieCell.swift
//  01 Flicks
//
//  Created by YingYing Zhang on 9/14/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var userRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
