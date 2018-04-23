//
//  HeaderView.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/20/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
protocol HeaderViewDelegate: class {
    func didTapShowAll(genre: String)
}

class HeaderView: UITableViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    weak var delegate: HeaderViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentForCell(title: String) {
        genreLabel.text = title
    }

    @IBAction func tapShowAll(_ sender: Any) {
        if let genreStr = genreLabel.text {
            delegate?.didTapShowAll(genre: genreStr)
        }
    }
}
