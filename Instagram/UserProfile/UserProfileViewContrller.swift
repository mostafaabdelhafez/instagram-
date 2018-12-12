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
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerid")
        FetchUser()
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
