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

    func setContentForCell(song: Song) {
        nameLabel.text = song.name
        imgSong.image = UIImage(contentsOfFile: song.imageLink)
        singerLabel.text = song.singer
    }
}
