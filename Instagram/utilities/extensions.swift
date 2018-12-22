//
//  extensions.swift
//  Instagram
//
//  Created by mostafa on 11/30/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import  UIKit
extension UIColor{
    
    
   static func RGB(red:CGFloat,green:CGFloat,blue:CGFloat)->UIColor{
        
        
return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
extension UIView{
    
    func Anchor(Top:NSLayoutYAxisAnchor?,Left:NSLayoutXAxisAnchor?,Bottom:NSLayoutYAxisAnchor?,Right:NSLayoutXAxisAnchor?,TopPadding:CGFloat,LeftPadding:CGFloat,BottomPadding:CGFloat,RightPadding:CGFloat,Width:CGFloat,Height:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let Top = Top{
            self.topAnchor.constraint(equalTo: Top, constant: TopPadding).isActive = true
            
        }
        if let Left = Left{
            self.leftAnchor.constraint(equalTo: Left, constant: LeftPadding).isActive = true}
        if let Bottom = Bottom{
            self.bottomAnchor.constraint(equalTo: Bottom, constant: BottomPadding).isActive = true}
        if let Right = Right{
            self.rightAnchor.constraint(equalTo: Right, constant: RightPadding).isActive = true}
        if Width != 0{
            self.widthAnchor.constraint(equalToConstant: Width).isActive = true
        }
        if Height != 0{
            self.heightAnchor.constraint(equalToConstant: Height).isActive = true
        }
    
    }
    
    
}
