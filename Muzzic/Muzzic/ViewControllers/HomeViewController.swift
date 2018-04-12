//
//  HomeViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/10/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var musicCollectionView: UICollectionView!
    @IBOutlet weak var audioCollectionView: UICollectionView!
    @IBOutlet weak var rockCollectionView: UICollectionView!
    @IBOutlet weak var ambientCollectionView: UICollectionView!
    @IBOutlet weak var classicalCollectionView: UICollectionView!
    @IBOutlet weak var countryCollectionView: UICollectionView!

    var dataSource: SongDataSource!
    var rockMusics = [GetSongOutput]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMusics()
        configCollectionView()
    }
    func configCollectionView() {
        self.rockCollectionView
            .register(UINib(nibName: "SongCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
    }
    func fetchMusics() {
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "rock") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    self.rockMusics = data
                    self.dataSource = SongDataSource(items: self.rockMusics)
                    self.rockCollectionView.dataSource = self.dataSource
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapSeeMusic(_ sender: Any) {
    }
    @IBAction func tapSeeAudio(_ sender: Any) {
    }
    @IBAction func tapSeeRock(_ sender: Any) {
    }
    @IBAction func tapSeeAmbient(_ sender: Any) {
    }
    @IBAction func tapSeeClassical(_ sender: Any) {
    }
    @IBAction func tapSeeCountry(_ sender: Any) {
    }
}
