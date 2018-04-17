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

    var musicDataSource: SongDataSource!
    var audioDataSource: SongDataSource!
    var rockDataSource: SongDataSource!
    var ambientDataSource: SongDataSource!
    var classicalDataSource: SongDataSource!
    var countryDataSource: SongDataSource!

    var musicArr: [Song]?
    var audioArr: [Song]?
    var rockArr: [Song]?
    var ambientArr: [Song]?
    var classicalArr: [Song]?
    var countryArr: [Song]?

    var genre = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllGenres()
        configCollectionView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Views
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK: - Actions
    @IBAction func tapSeeMusic(_ sender: Any) {
        genre = Genre.music
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }
    @IBAction func tapSeeAudio(_ sender: Any) {
        genre = Genre.audio
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }
    @IBAction func tapSeeRock(_ sender: Any) {
        genre = Genre.rock
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }
    @IBAction func tapSeeAmbient(_ sender: Any) {
        genre = Genre.ambient
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }
    @IBAction func tapSeeClassical(_ sender: Any) {
        genre = Genre.classical
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }
    @IBAction func tapSeeCountry(_ sender: Any) {
        genre = Genre.country
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }
    @IBAction func tapSearch(_ sender: Any) {
        self.performSegue(withIdentifier: Segue.showSearch, sender: nil)
    }

    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showGenreScreen, let vc = segue.destination as? GenreViewController {
            vc.genreString = genre
        }
    }
}
extension HomeViewController {
    // MARK: - Config nib for custom Cell
    fileprivate func configCollectionView() {
        let customCellName = UINib(nibName: "SongCollectionViewCell", bundle: nil)
        self.musicCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
        self.audioCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell" )
        self.rockCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
        self.ambientCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
        self.classicalCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
        self.countryCollectionView
            .register(customCellName, forCellWithReuseIdentifier: "CustomCell")
    }
    // MARK: - Fetch Data Music
    func fetchAllGenres() {
        fetchMusic()
        fetchAudio()
        fetchRock()
        fetchAmbient()
        fetchClassical()
        fetchCountry()
    }
    // MARK: All
    func fetchMusic() {
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    self.musicArr = data.collections
                    self.musicDataSource = SongDataSource(items: data.collections)
                    self.musicCollectionView.dataSource = self.musicDataSource
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Audio
    func fetchAudio() {
        DispatchQueue.global(qos: .userInitiated).async {
            SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Audio") { (result) in
                switch result {
                case .success(let output):
                    if let data = output {
                        self.audioArr = data.collections
                        self.audioDataSource = SongDataSource(items: data.collections)
                        self.audioCollectionView.dataSource = self.audioDataSource
                    }
                case .failure(let error):
                    print(error?.description ?? "")
                }
            }
        }
    }
    // MARK: Rock
    func fetchRock() {
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Rock") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    self.rockArr = data.collections
                    self.rockDataSource = SongDataSource(items: data.collections)
                    self.rockCollectionView.dataSource = self.rockDataSource
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Ambient
    func fetchAmbient() {
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Ambient") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    self.ambientArr = data.collections
                    self.ambientDataSource = SongDataSource(items: data.collections)
                    self.ambientCollectionView.dataSource = self.ambientDataSource
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Classical
    func fetchClassical() {
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Classical") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    self.classicalArr = data.collections
                    self.classicalDataSource = SongDataSource(items: data.collections)
                    self.classicalCollectionView.dataSource = self.classicalDataSource
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Country
    func fetchCountry() {
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Country") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    self.countryArr = data.collections
                    self.countryDataSource = SongDataSource(items: data.collections)
                    self.countryCollectionView.dataSource = self.countryDataSource
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let newViewController = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
        var mySongs = [Song]()
        switch collectionView {
        case musicCollectionView:
            if let songs = musicArr {
                mySongs = songs
            }
        case audioCollectionView:
            if let songs = audioArr {
                mySongs = songs
            }
        case ambientCollectionView:
            if let songs = ambientArr {
                mySongs = songs
            }
        case rockCollectionView:
            if let songs = rockArr {
                mySongs = songs
            }
        case classicalCollectionView:
            if let songs = classicalArr {
                mySongs = songs
            }
        case countryCollectionView:
            if let songs = countryArr {
                mySongs = songs
            }
        default:
            break
        }
        newViewController.songs = mySongs
        newViewController.trackIndex = indexPath.row
        self.present(newViewController, animated: true, completion: nil)
    }
}
