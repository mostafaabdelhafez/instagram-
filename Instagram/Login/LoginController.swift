//
//  LoginController.swift
//  Instagram
//
//  Created by mostafa on 12/10/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import Firebase
class LoginController:UIViewController{
    let TopView:UIView = {
        let LogoImg = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
       let view = UIView()
        view.addSubview(LogoImg)
        LogoImg.Anchor(Top: nil, Left: nil, Bottom: nil, Right: nil, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 0)
        LogoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LogoImg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.RGB(red: 0, green: 120, blue: 175)
        return view
        
    }()
    let EmailTextField:UITextField = {
        let TextField = UITextField()
        TextField.placeholder = "Email"
        TextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        TextField.borderStyle = .roundedRect
        TextField.font=UIFont.systemFont(ofSize: 14)
        TextField.translatesAutoresizingMaskIntoConstraints = false
        TextField.addTarget(self, action: #selector(ChangeBtnColor), for: .editingChanged)
        return TextField
    }()
    let PasswardTextField:UITextField = {
        let TextField = UITextField()
        TextField.placeholder = "Passward"
        TextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        TextField.borderStyle = .roundedRect
        TextField.isSecureTextEntry = true
        TextField.font=UIFont.systemFont(ofSize: 14)
        TextField.translatesAutoresizingMaskIntoConstraints = false
       TextField.addTarget(self, action: #selector(ChangeBtnColor), for: .editingChanged)
        return TextField
    }()
    
    let LoginBtn:UIButton = {
        
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setTitle("Login", for: .normal)
        Button.backgroundColor = UIColor.RGB(red: 149, green: 204, blue: 244)
        Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        Button.addTarget(self, action: #selector(HandleLoginBtn), for: .touchUpInside)
        Button.isEnabled = false
        return Button
    }()
    
    let DontHaveAccBtn:UIButton = {
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(HandleSignUpBtn), for: .touchUpInside)
        let AttributedString = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
        AttributedString.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)]))
        button.setAttributedTitle(AttributedString, for: [])
       // button.setTitle("Don't have an account? Sign up", for:.normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(DontHaveAccBtn)
        DontHaveAccBtn.Anchor(Top: nil, Left:view.leftAnchor , Bottom: view.bottomAnchor, Right: view.rightAnchor, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 50)
        SetUpTopView()
        HandleStackView()
    }
    @objc func HandleLoginBtn(){
        guard let Email = EmailTextField.text else{return}
        guard let Passward = PasswardTextField.text else{return}
        
        Auth.auth().signIn(withEmail: Email, password: Passward) { (User, err) in
            if err == nil{
                print(Auth.auth().currentUser?.uid)
                guard let MainTapbarVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{return}
                MainTapbarVC.SetUpVC()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    @objc func ChangeBtnColor(){
        
        let istextfieldvalid = EmailTextField.text?.characters.count ?? 0 > 0 && PasswardTextField.text?.characters.count ?? 0 > 0
        if istextfieldvalid{
            LoginBtn.backgroundColor = UIColor.RGB(red: 17, green: 154, blue: 237)
            LoginBtn.isEnabled = true
            
        }
        else{
            LoginBtn.backgroundColor = UIColor.RGB(red: 149, green: 204, blue: 244)
            LoginBtn.isEnabled = false
        }
    }
    
    func HandleStackView(){
        let stackview = UIStackView(arrangedSubviews: [EmailTextField,PasswardTextField,LoginBtn])
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        stackview.Anchor(Top: TopView.bottomAnchor, Left: view.leftAnchor, Bottom: nil, Right: view.rightAnchor, TopPadding: 40, LeftPadding: 40, BottomPadding: 0, RightPadding: -40, Width: 0, Height: 140)
        
    }
    
    func SetUpTopView(){
        view.addSubview(TopView)
        
        TopView.Anchor(Top: view.topAnchor, Left: view.leftAnchor, Bottom: nil, Right: view.rightAnchor, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 150)
    }
    @objc func HandleSignUpBtn(){
        let signup = SignUpVC()
        navigationController?.pushViewController(signup, animated: true)
        
    }
}
