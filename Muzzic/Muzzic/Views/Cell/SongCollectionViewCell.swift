//
//  SongCollectionViewCell.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/10/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var songImg: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentForCell(song: Song) {
        songImg.setImageFromURL(urlLink: song.imageLink)
        songNameLabel.text = song.name
        singerLabel.text = song.singer
    }

}
