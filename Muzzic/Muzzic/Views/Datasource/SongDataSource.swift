//
//  SongDataSource.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/11/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import UIKit

public class SongDataSource: NSObject, UICollectionViewDataSource {
    var items: [Song]

    init(items: [Song]!) {
        self.items = items
        super.init()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? SongCollectionViewCell
        cell?.songImg.loadImgFrom(urlLink: items[indexPath.row].imageLink)
        cell?.songNameLabel.text = items[indexPath.row].name
        cell?.singerLabel.text = items[indexPath.row].singer
        return cell!
    }
}
