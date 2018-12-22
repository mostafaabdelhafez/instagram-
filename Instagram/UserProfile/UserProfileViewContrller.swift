//
//  UserProfileViewContrller.swift
//  Instagram
//
//  Created by mostafa on 12/5/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import  Firebase
class UserProfileViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let cellID = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerid")
        FetchUser()
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        SetUpLogOutBtn()
    }
    func SetUpLogOutBtn(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(HandleLogOutBtn))
        
        
    }
    @objc func HandleLogOutBtn(){
        
        let AlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        AlertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do{
                try Auth.auth().signOut()
                let LoginVC = LoginController()
                let NavC = UINavigationController(rootViewController: LoginVC)
                self.present(NavC, animated: true, completion: nil)
                
            }
            catch{print("Failed")}
            
        }))
        AlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(AlertController, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        Cell.backgroundColor = .red
        return Cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2)/3
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerid", for: indexPath) as! UserProfileHeader
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    var user:User?
    func FetchUser(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firebase.Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (Snapshot) in
            print(Snapshot.value ?? "" )
            guard let DictofSnapShot = Snapshot.value as? [String:Any] else{return}
            self.user = User(Dictionary: DictofSnapShot)
            self.navigationItem.title = self.user?.userName
           self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch user:",err)
        }
    }
}
struct User {
    var userName : String
    var ProfileImageUrl:String
    init(Dictionary:[String:Any]) {
        self.userName = Dictionary["username"] as? String ?? ""
        self.ProfileImageUrl = Dictionary["ProfileImageURL"] as? String ?? ""
    }
}
