//
//  PlaylistViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/19/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {
    var songs = [Song]()
    @IBOutlet weak var songTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        configNaviBar()
        getSongFromCoreData()
        configTableViewCell()
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
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PlaylistViewCell

        let currentSong = songs[indexPath.row]
        cell?.nameLabel.text = currentSong.name
        cell?.imgSong.image = UIImage(contentsOfFile: currentSong.imageLink)
        cell?.singerLabel.text = currentSong.singer
        return cell!
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
// MARK: - Core data
extension PlaylistViewController {
    func getSongFromCoreData() {
        songs = DBManager.sharedInstance.getArrSong()
        songTableView.reloadData()
    }
}
