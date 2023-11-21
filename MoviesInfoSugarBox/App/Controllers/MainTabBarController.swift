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
        let icon1 = UITabBarItem(title: "SugarBox", image: UIImage(systemName: "paperplane"), selectedImage: UIImage(systemName: "paperplane.fill"))
        item1.tabBarItem = icon1
        let controllers = [item1]
        self.viewControllers = controllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
