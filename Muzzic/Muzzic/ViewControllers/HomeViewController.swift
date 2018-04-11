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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
