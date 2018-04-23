//
//  PlaylistViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/19/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var songs = [Song]()
    fileprivate var isSearching = false
    fileprivate var filterData = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        configNaviBar()
        getSongFromCoreData()
        configTableViewCell()
        configSearchBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
// MARK: - Config navigation
extension PlaylistViewController {

    fileprivate func configNaviBar() {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    fileprivate func configTableViewCell() {
        let customCellName = UINib(nibName: "PlaylistViewCell", bundle: nil)
        self.songTableView.register(customCellName, forCellReuseIdentifier: "CustomCell")
    }
}
// MARK: - Table view Delegate
extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching {
            return songs.count
        } else {
            return filterData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = songTableView.dequeueReusableCell(withIdentifier: "CustomCell",
                                                           for: indexPath) as? PlaylistViewCell else {
            return UITableViewCell()
        }
        var currentSong = songs[indexPath.row]
        if isSearching {
            currentSong = filterData[indexPath.row]
        }

        cell.setContentForCell(song: currentSong)

        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currenSong = songs[indexPath.row]
            DBManager.sharedInstance.removeSong(songID: currenSong.songID)
            DownloadManager.sharedInstance.deleteData(name: String(currenSong.songID))
            DispatchQueue.main.async {
                self.getSongFromCoreData()
                self.songTableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
        newViewController.trackIndex = indexPath.row
        newViewController.songs = songs
        newViewController.isOffline = true
        self.present(newViewController, animated: true, completion: nil)
    }
}
// MARK: - Search bar delegate
extension PlaylistViewController: UISearchBarDelegate {

    fileprivate func configSearchBar() {
        searchBar.delegate = self
        searchBar.tintColor = UIColor.black
        searchBar.returnKeyType = UIReturnKeyType.search
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else {
            return
        }

        if searchText.isEmpty {
            isSearching = false
            searchBar.resignFirstResponder()
            self.songTableView.reloadData()
        } else {
            isSearching = true
            filterData = songs.filter({
                $0.name.lowercased().contains(searchText.lowercased())
            })
            self.songTableView.reloadData()
        }
    }
}
// MARK: - Core data
extension PlaylistViewController {
    fileprivate func getSongFromCoreData() {
        songs = DBManager.sharedInstance.getArrSong()
        songTableView.reloadData()
    }
}
