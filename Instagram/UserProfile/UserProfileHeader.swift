//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by mostafa on 12/6/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import  Firebase
class UserProfileHeader:UICollectionViewCell{
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ProfileImage)
        backgroundColor = .blue
        ProfileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        ProfileImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive=true
        ProfileImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: 80).isActive=true
        ProfileImage.layer.cornerRadius = 40
        ProfileImage.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .red
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
        
    }()
    var user:User?{
        didSet{
            SetUpProfileImage()
        }
    }

    func SetUpProfileImage(){
        guard let ProfileImgUrl = user?.ProfileImageUrl else {return}
        guard let url = URL(string:ProfileImgUrl) else{return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                
                print("failed to fetch Data:",error)
                return
            }
            guard let data = data else {return}
            let Image = UIImage(data: data)
            DispatchQueue.main.async {
                self.ProfileImage.image = Image
                
            }
            
        }).resume()
    }
}
