//
//  ViewController.swift
//  Instagram
//
//  Created by mostafa on 11/30/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase

class SignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    

    let PlusButton:UIButton = {
        
        let Button = UIButton()
          Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        Button.addTarget(self, action: #selector(HandlePlusPhoto), for: .touchUpInside)
        return Button
    }()
    @objc func HandlePlusPhoto(){
        
        
        let ImagePicker = UIImagePickerController()
        present(ImagePicker,animated:true,completion: nil)
        ImagePicker.delegate = self
        ImagePicker.allowsEditing = true
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let editedImge = info["UIImagePickerControllerEditedImage"] as? UIImage{
            PlusButton.setImage(editedImge, for: [])
        }
        else if let OriginalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            PlusButton.setImage(OriginalImg, for: .normal) }
        PlusButton.layer.cornerRadius = PlusButton.frame.width/2
        PlusButton.layer.masksToBounds = true
        PlusButton.layer.borderColor = UIColor.black.cgColor
        PlusButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)

        
    }
    let SignUp:UIButton = {
        
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setTitle("Sign Up", for: .normal)
        Button.backgroundColor = UIColor.RGB(red: 149, green: 204, blue: 244)
        Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        Button.addTarget(self, action: #selector(HandleSignUp), for: .touchUpInside)
        Button.isEnabled = false
        return Button
    }()
    @objc func HandleSignUp(){
        guard let email = EmailTextField.text,email.characters.count > 0 else {return}
        guard let passward = PasswardTextField.text,email.characters.count > 0 else {return}
        guard let username = UserNameTextField.text,email.characters.count > 0 else {return}
        
            
        
    

        Auth.auth().createUser(withEmail: email, password: passward) { (AuthUser, error) in
            if let error = error {
                print("Failed to Create User",error
                )
                return
            }
            guard let Img = self.PlusButton.imageView?.image else{return}
            guard let uploadData = UIImageJPEGRepresentation(Img, 0.3) else {return}
            print (uploadData)
            
            let filename = NSUUID().uuidString
            
            let storageReference = Storage.storage().reference().child("profile_images").child(filename)
            let metaData = StorageMetadata()
            let uploadtask = storageReference.putData(uploadData, metadata: nil, completion: { (Metadata, err) in
                
                if let err = err {
                    print ("Failed to upload",err)
                }
                guard let Meta = Metadata else {return
                    
                }
                print(Meta)
                
                
                
                storageReference.downloadURL(completion: { (URL,error) in
                    if let error = error{
                        
                        print("Failed to download",error)
                        return
                    }
                    if let downloadedurl = URL {
                        
                        print("sussesfull downloadd",downloadedurl.absoluteString)
                        
                        guard let userid = Auth.auth().currentUser?.uid else{return}
                        let Dictvalues = ["username":username,"ProfileImageURL":downloadedurl.absoluteString]
                        let Values = [userid:Dictvalues]
                        Database.database().reference().child("users").setValue(Values,withCompletionBlock: { (error, reference) in
                            if let error = error{
                                print(error)
                                return
                            }
                            
                            
                            print("user added with id ->",userid)
                            
                        })
                        
                        
                        
                    }
                    
                })
                
            })
            uploadtask.resume()
            
            

            
            
            
         
        }
        
    }
    
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
    @objc func ChangeBtnColor(){
        let istextfieldvalid = EmailTextField.text?.characters.count ?? 0 > 0 && PasswardTextField.text?.characters.count ?? 0 > 0 && UserNameTextField.text?.characters.count ?? 0 > 0
        if istextfieldvalid{
            SignUp.backgroundColor = UIColor.RGB(red: 17, green: 154, blue: 237)
            SignUp.isEnabled = true

        }
        else{
            SignUp.backgroundColor = UIColor.RGB(red: 149, green: 204, blue: 244)
            SignUp.isEnabled = false
        }
    }
    let UserNameTextField:UITextField = {
        let TextField = UITextField()
        TextField.placeholder = "UserName"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(PlusButton)
        PlusButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        PlusButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        PlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PlusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        SetupTextField()
        
        
            

        }
        
        
        
        
        
        
        
    
    fileprivate func SetupTextField(){
        let StackView = UIStackView(arrangedSubviews: [EmailTextField,UserNameTextField,PasswardTextField,SignUp])
       StackView.distribution = .fillEqually
        StackView.axis = .vertical
        StackView.translatesAutoresizingMaskIntoConstraints = false
        StackView.spacing = 10
        view.addSubview(StackView)
        NSLayoutConstraint.activate([EmailTextField.heightAnchor.constraint(equalToConstant: 40),
   StackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
  StackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
  StackView.topAnchor.constraint(equalTo: PlusButton.bottomAnchor, constant: 20),
        StackView.heightAnchor.constraint(equalToConstant: 200)])
        


    }

}



