//
//  VideoCell.swift
//  Vimeo
//
//  Created by Jisan Zaman on 7/8/15.
//  Copyright (c) 2015 Jisan Zaman. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet var nameLabel:UILabel?
    @IBOutlet var durationLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
