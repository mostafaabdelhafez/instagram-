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
class MainTabBarController: UITabBarController,UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2{
            let photoselectVC = PhotoSelect(collectionViewLayout: UICollectionViewFlowLayout())
            let photoselectNavController = UINavigationController(rootViewController: photoselectVC)
            present(photoselectNavController, animated: true, completion: nil)
            return false
        }
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let loginCont = LoginController()
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: loginCont)
               self.present(nav, animated: true,completion:nil)

            }
            return
        }
        SetUpVC()
   
    
    }
    func SetUpVC(){
        
        
        let HomeNavController = setupNavControlles(SelectedImage: #imageLiteral(resourceName: "home_selected"), UnSelectedImage: #imageLiteral(resourceName: "home_unselected"), rootviewcontroller: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let SearchNavController = setupNavControlles(SelectedImage: #imageLiteral(resourceName: "search_selected"), UnSelectedImage: #imageLiteral(resourceName: "search_unselected"))
        let PlusNavController = setupNavControlles(SelectedImage: #imageLiteral(resourceName: "plus_unselected"), UnSelectedImage: #imageLiteral(resourceName: "plus_unselected"))
        let LikeNavController = setupNavControlles(SelectedImage: #imageLiteral(resourceName: "like_selected"), UnSelectedImage:#imageLiteral(resourceName: "like_unselected"))
        let userprofileNavController = setupNavControlles(SelectedImage: #imageLiteral(resourceName: "profile_selected"), UnSelectedImage: #imageLiteral(resourceName: "profile_unselected"), rootviewcontroller: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        tabBar.tintColor = .black
        viewControllers=[HomeNavController,SearchNavController,PlusNavController,LikeNavController,userprofileNavController]
        for item in tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom:-4, right: 0)
        }
        
    }
    
    func setupNavControlles(SelectedImage:UIImage,UnSelectedImage:UIImage,rootviewcontroller:UIViewController = UIViewController()) -> UINavigationController{
        
        let NavVC = UINavigationController(rootViewController: rootviewcontroller)
        NavVC.tabBarItem.image = UnSelectedImage
        NavVC.tabBarItem.selectedImage = SelectedImage
        return NavVC
    }
    
}


