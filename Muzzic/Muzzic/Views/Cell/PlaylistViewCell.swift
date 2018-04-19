//
//  PlaylistViewCell.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/19/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class PlaylistViewCell: UITableViewCell {
    @IBOutlet weak var imgSong: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
