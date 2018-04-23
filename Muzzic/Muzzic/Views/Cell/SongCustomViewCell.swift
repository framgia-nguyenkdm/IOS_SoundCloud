//
//  SongCustomViewCell.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/16/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class SongCustomViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentCell(song: Song) {
        nameLabel.text = song.name
        singerLabel.text = song.singer
    }
}
