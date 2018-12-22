//
//  SelectedImg.swift
//  Instagram
//
//  Created by mostafa on 12/21/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
class SelectedImg:UICollectionViewCell{
    let CellImage : UIImageView = {
        
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(CellImage)
        CellImage.Anchor(Top: topAnchor, Left: leftAnchor, Bottom: bottomAnchor, Right: rightAnchor, TopPadding: 0, LeftPadding: 0, BottomPadding: 0, RightPadding: 0, Width: 0, Height: 0)
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
