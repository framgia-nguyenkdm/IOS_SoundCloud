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
        self.performSegue(withIdentifier: "showGenreList", sender: nil)
    }
    @IBAction func tapSeeAudio(_ sender: Any) {
        genre = Genre.audio
        self.performSegue(withIdentifier: "showGenreList", sender: nil)
    }
    @IBAction func tapSeeRock(_ sender: Any) {
        genre = Genre.rock
        self.performSegue(withIdentifier: "showGenreList", sender: nil)
    }
    @IBAction func tapSeeAmbient(_ sender: Any) {
        genre = Genre.ambient
        self.performSegue(withIdentifier: "showGenreList", sender: nil)
    }
    @IBAction func tapSeeClassical(_ sender: Any) {
        genre = Genre.classical
        self.performSegue(withIdentifier: "showGenreList", sender: nil)
    }
    @IBAction func tapSeeCountry(_ sender: Any) {
        genre = Genre.country
        self.performSegue(withIdentifier: "showGenreList", sender: nil)
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
    func configCollectionView() {
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
                    DispatchQueue.main.async {
                        self.musicDataSource = SongDataSource(items: data)
                        self.musicCollectionView.dataSource = self.musicDataSource
                    }
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
                        DispatchQueue.main.async {
                            self.audioDataSource = SongDataSource(items: data)
                            self.audioCollectionView.dataSource = self.audioDataSource
                        }
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
                    DispatchQueue.main.async {
                        self.rockDataSource = SongDataSource(items: data)
                        self.rockCollectionView.dataSource = self.rockDataSource
                    }
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
                    DispatchQueue.main.async {
                        self.ambientDataSource = SongDataSource(items: data)
                        self.ambientCollectionView.dataSource = self.ambientDataSource
                    }
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
                    DispatchQueue.main.async {
                        self.classicalDataSource = SongDataSource(items: data)
                        self.classicalCollectionView.dataSource = self.classicalDataSource
                    }
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
                    DispatchQueue.main.async {
                        self.countryDataSource = SongDataSource(items: data)
                        self.countryCollectionView.dataSource = self.countryDataSource
                    }
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
}
