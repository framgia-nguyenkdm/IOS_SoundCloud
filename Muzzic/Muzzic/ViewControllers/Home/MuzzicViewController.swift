//
//  MuzzicViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/20/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class MuzzicViewController: UIViewController {

    @IBOutlet private weak var myTableView: UITableView!
    fileprivate var genreSections = [""]

    var genre = ""
    var mySections = [SectionData]()
    let dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllGenres()
        configTableViewCell()
    }

    // MARK: - Views
    override func viewWillAppear(_ animated: Bool) {
        configNaviBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func tapSearch(_ sender: Any) {
        self.performSegue(withIdentifier: Segue.showSearch, sender: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showGenreScreen, let vc = segue.destination as? GenreViewController {
            vc.genreString = genre
        }
    }

}
// MARK: - Fetch Data Music
extension MuzzicViewController {

    func fetchAllGenres() {
        self.showLoading()

        fetchMusic()
        fetchAudio()
        fetchRock()
        fetchAmbient()
        fetchClassical()
        fetchCountry()
        dispatchGroup.notify(queue: .main) {
            self.myTableView.reloadData()
            self.hideLoading()
        }
    }
    // MARK: All
    func fetchMusic() {
        dispatchGroup.enter()
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    let musicSection = SectionData(title: "New Music", data: data.collections)
                    self.mySections.append(musicSection)
                    self.dispatchGroup.leave()
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Audio
    func fetchAudio() {
        dispatchGroup.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Audio") { (result) in
                switch result {
                case .success(let output):
                    if let data = output {
                        let musicSection = SectionData(title: "Audio", data: data.collections)
                        self.mySections.append(musicSection)
                        self.dispatchGroup.leave()
                    }
                case .failure(let error):
                    print(error?.description ?? "")
                }
            }
        }
    }
    // MARK: Rock
    func fetchRock() {
        dispatchGroup.enter()
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Rock") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    let musicSection = SectionData(title: "Alternative Rock", data: data.collections)
                    self.mySections.append(musicSection)
                    self.dispatchGroup.leave()
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Ambient
    func fetchAmbient() {
        dispatchGroup.enter()
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Ambient") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    let musicSection = SectionData(title: "Ambient", data: data.collections)
                    self.mySections.append(musicSection)
                    self.dispatchGroup.leave()
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Classical
    func fetchClassical() {
        dispatchGroup.enter()
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Classical") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    let musicSection = SectionData(title: "Classical", data: data.collections)
                    self.mySections.append(musicSection)
                    self.dispatchGroup.leave()
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
    // MARK: Country
    func fetchCountry() {
        dispatchGroup.enter()
        SongRespositoryImpl.sharedInstance.getSongByGenre(genre: "Country") { (result) in
            switch result {
            case .success(let output):
                if let data = output {
                    let musicSection = SectionData(title: "Country", data: data.collections)
                    self.mySections.append(musicSection)
                    self.dispatchGroup.leave()
                }
            case .failure(let error):
                print(error?.description ?? "")
            }
        }
    }
}
// MARK: - Config
extension MuzzicViewController {
    func configTableViewCell() {
        let nibName = UINib(nibName: "GenreTableViewCell", bundle: nil)
        self.myTableView.register(nibName, forCellReuseIdentifier: "GenreCell")
    }

    func configNaviBar() {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
// MARK: - Table view delegate, datasource
extension MuzzicViewController: UITableViewDelegate, UITableViewDataSource {
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("HeaderView",
                                                        owner: self,
                                                        options: nil)?.first as? HeaderView else {
            return UIView()
        }
        headerView.setContentForCell(title: mySections[section].title)
        headerView.delegate = self
        return headerView
    }
    // Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "GenreCell") as? GenreTableViewCell else {
            return UITableViewCell()
        }
        cell.items = mySections[indexPath.section].data
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension MuzzicViewController: HeaderViewDelegate, GenreTableViewDelegate {
    func didTapShowAll(genre: String) {
        self.genre = genre
        self.performSegue(withIdentifier: Segue.showGenreScreen, sender: nil)
    }

    func didTapCollectionCell(index: Int, songs: [Song]) {
        let newViewController = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
        newViewController.songs = songs
        newViewController.trackIndex = index
        self.present(newViewController, animated: true, completion: nil)
    }
}
