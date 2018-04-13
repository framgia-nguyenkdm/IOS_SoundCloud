//
//  GenreViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/12/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    var dataSource: SongDataSource!
    var songs = [Song]()
    var nextPageURL = ""
    var genreString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUIWithGenre()
    }
}
extension GenreViewController {

    fileprivate func setupUIWithGenre() {
        configNavigationBar(title: genreString)
        if genreString == "Music" {
            genreString = ""
        }
        SongRespositoryImpl.sharedInstance.getSongByGenrePaging(genre: genreString) { (result) in
            switch result {
            case .success(let output):
                if let output = output {
                    self.nextPageURL = output.nextPage
                    for item in output.collections {
                        self.songs.append(item)
                    }
                    DispatchQueue.main.async {
                        self.myCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }

    func configNavigationBar(title: String) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "ChalkDuster", size: 20)!
        ]
    }

    func configCollectionViewCell() {
        let customCellName = UINib(nibName: "SongCollectionViewCell", bundle: nil)
        self.myCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
    }
}
extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView
            .dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? SongCollectionViewCell
        cell?.songImg.loadImgFrom(urlLink: songs[indexPath.row].imageLink)
        cell?.songNameLabel.text = songs[indexPath.row].name
        cell?.singerLabel.text = songs[indexPath.row].singer
        return cell!
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return CGSize(width: 0, height: 0)
            }

            let cellsPerRow = 3
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
            let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(cellsPerRow))
            let height = Int((collectionView.bounds.width*1.5) / CGFloat(cellsPerRow))
            return CGSize(width: width, height: height)
        }
}
