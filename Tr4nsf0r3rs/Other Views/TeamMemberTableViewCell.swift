//
//  TeamMemberTableViewCell.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

class TeamMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var overallRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
