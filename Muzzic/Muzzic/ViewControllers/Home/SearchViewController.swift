//
//  SearchViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/13/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    var songs = [Song]()

    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

        configNaviBar()
        configTableViewCell()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !songs.isEmpty {
            return songs.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SongCustomViewCell

        cell?.nameLabel?.text = songs[indexPath.row].name
        cell?.singerLabel.text = songs[indexPath.row].singer

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
        newViewController.trackIndex = indexPath.row
        newViewController.songs = songs
        self.present(newViewController, animated: true, completion: nil)
    }
}
extension SearchViewController {
    fileprivate func configNaviBar() {
        self.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        searchController.searchBar.placeholder  = "Explore Soundcloud"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    fileprivate func configTableViewCell() {
        let customCellName = UINib(nibName: "SongCustomViewCell", bundle: nil)
        self.tableView.register(customCellName, forCellReuseIdentifier: "Cell")
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keywords = searchBar.text {
            SongRespositoryImpl.sharedInstance.getSongBySearch(searchStr: keywords) { (result) in
                switch result {
                case .success(let output):
                    if let data = output {
                        self.songs = data.collections
                        print(self.songs.count)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error?.description ?? "")
                }
            }
        }
    }
}
