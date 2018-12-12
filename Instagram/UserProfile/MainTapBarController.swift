//
//  MainTapBarController.swift
//  Instagram
//
//  Created by mostafa on 12/5/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .red
        let NavVC = UINavigationController(rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        NavVC.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        NavVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
        viewControllers=[NavVC,UIViewController()]
    
    }
    
}
