//
//  MainTabBarController.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let item1 = HomeViewController.init(viewModel: ListViewModel())
        let icon1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        item1.tabBarItem = icon1
        
        let item2 = ViewController()
        let icon2 = UITabBarItem(title: "Movies", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        item2.tabBarItem = icon2
        
        let item3 = ViewController()
        let icon3 = UITabBarItem(title: "Shows", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv.fill"))
        item3.tabBarItem = icon3
        let controllers = [item1, item2, item3]
        self.viewControllers = controllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    
}
