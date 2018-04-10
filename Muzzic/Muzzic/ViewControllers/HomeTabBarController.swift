//
//  HomeTabBarController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/10/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//
import UIKit

enum HomeTabBarItem {
    case home
    case playList

    var title: String? {
        return nil
    }

    var image: UIImage {
        switch self {
        case .home:
            return #imageLiteral(resourceName: "tabbar_icon_home").withRenderingMode(.alwaysOriginal)
        case .playList:
            return #imageLiteral(resourceName: "tabbar_icon_download").withRenderingMode(.alwaysOriginal)
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .home:
            return #imageLiteral(resourceName: "tabbar_icon_home_active").withRenderingMode(.alwaysOriginal)
        case .playList:
            return #imageLiteral(resourceName: "tabbar_icon_download_active").withRenderingMode(.alwaysOriginal)
        }
    }

    var controller: UIViewController {
        switch self {
        case .home:
            return (UIStoryboard.home().instantiateInitialViewController() as? HomeViewController)!
        case .playList:
            return (UIStoryboard.playlist().instantiateInitialViewController() as? PlaylistViewController)!
        }
    }

    var index: Int {
        switch self {
        case .home:
            return 0
        case .playList:
            return 1
        }
    }

    static let tabbarItems = [HomeTabBarItem.home, HomeTabBarItem.playList]

}

class TabBarItem: UITabBarItem {
    var tabItem: HomeTabBarItem

    init(item: HomeTabBarItem) {
        self.tabItem = item
        super.init()
        self.image = item.image
        self.selectedImage = item.selectedImage
        self.title = item.title
        self.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()
        configTabbar()
        setSelectedItem(item: .home)

    }

    func setSelectedItem(item: HomeTabBarItem) {
        selectedIndex = item.index
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func configTabbar() {
        let tintColor = UIColor.red
        self.tabBar.tintColor = tintColor
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.white
        viewControllers = HomeTabBarItem.tabbarItems.map { item in
            let vc = item.controller
            vc.tabBarItem = TabBarItem(item: item)
            return vc
        }
    }
}
