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
    
    let gridButton:UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    let listButton:UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    let bookmarkButton:UIButton = {
        let button = UIButton(type:.system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    let usernamelabel:UILabel={
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let postlabel:UILabel = {
        let label = UILabel()
        label.text = "11\nposts"
        label.numberOfLines = 0
        label.textAlignment = .center
        let AttributedString = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        AttributedString.append(NSAttributedString(string: "Posts", attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightGray,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)]))
        label.attributedText = AttributedString
        return label
    }()
    let followerslabel:UILabel = {
        let label = UILabel()
        label.text = "11\nposts"
        label.numberOfLines = 0
        label.textAlignment = .center
        let AttributedString = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        AttributedString.append(NSAttributedString(string: "Followers", attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightGray,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)]))
        label.attributedText = AttributedString
        return label
    }()
    let followinglabel:UILabel = {
        let label = UILabel()
        label.text = "11\nposts"
        label.numberOfLines = 0
        label.textAlignment = .center
        let AttributedString = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        AttributedString.append(NSAttributedString(string: "Following", attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightGray,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)]))
        label.attributedText = AttributedString
        return label
    }()
    

    
    let EditProfileBtn:UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: [])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: [])
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(ProfileImage)
        backgroundColor = .white
        ProfileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        ProfileImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive=true
        ProfileImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: 80).isActive=true
        ProfileImage.layer.cornerRadius = 40
        ProfileImage.clipsToBounds = true
        SetupBottomBar()
        SetupUserStats()
        addSubview(EditProfileBtn)
        EditProfileBtn.Anchor(Top: postlabel.bottomAnchor, Left: postlabel.leftAnchor, Bottom: nil, Right: followinglabel.rightAnchor, TopPadding: 8, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 34)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupUserStats(){
        
        let Stackview = UIStackView(arrangedSubviews: [postlabel,followerslabel,followinglabel])
        Stackview.distribution = .fillEqually
        Stackview.alignment = .center
        addSubview(Stackview)
        Stackview.Anchor(Top: topAnchor, Left:ProfileImage.rightAnchor, Bottom: nil, Right: rightAnchor, TopPadding: 12, LeftPadding: 8, BottomPadding: 0, RightPadding:-12, Width: 0, Height: 0)
    }

    func SetupBottomBar(){
        
        let StackView = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
        addSubview(StackView)
        addSubview(usernamelabel)
        usernamelabel.Anchor(Top: ProfileImage.bottomAnchor, Left: leftAnchor, Bottom: gridButton.topAnchor, Right: rightAnchor, TopPadding: 4, LeftPadding: 12, BottomPadding: 0, RightPadding: 12, Width: 0, Height: 0)
        StackView.Anchor(Top: nil, Left: leftAnchor, Bottom: self.bottomAnchor, Right: rightAnchor, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 50)
        StackView.distribution = .fillEqually
        let TopView = UIView()
        let bottomView = UIView()
        addSubview(bottomView)
        addSubview(TopView)
        bottomView.Anchor(Top: nil, Left: leftAnchor, Bottom: gridButton.topAnchor, Right: rightAnchor, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 1)
        bottomView.backgroundColor = UIColor.lightGray
        addSubview(bottomView)
        TopView.Anchor(Top: gridButton.bottomAnchor, Left: leftAnchor, Bottom: nil, Right: rightAnchor, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 1)
        TopView.backgroundColor = UIColor.lightGray
    }
    let ProfileImage: UIImageView = {
        let ImageView = UIImageView()
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
        
    }()
    var user:User?{
        didSet{
            SetUpProfileImage()
            usernamelabel.text = user?.userName
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
