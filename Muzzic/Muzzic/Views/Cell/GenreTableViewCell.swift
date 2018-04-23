//
//  GenreTableViewCell.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/20/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
protocol GenreTableViewDelegate: class {
    func didTapCollectionCell(index: Int, songs: [Song])
}

class GenreTableViewCell: UITableViewCell {
    @IBOutlet weak var myCollectionView: UICollectionView!
    weak var delegate: GenreTableViewDelegate?
    var items: [Song]! {
        didSet {
            self.myCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        let customCellName = UINib(nibName: "SongCollectionViewCell", bundle: nil)
        self.myCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
    }
}
extension GenreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? SongCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.setContentForCell(song: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapCollectionCell(index: indexPath.row, songs: items)
    }
}
