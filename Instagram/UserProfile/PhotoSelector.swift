//
//  PhotoSelector.swift
//  Instagram
//
//  Created by mostafa on 12/17/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import Photos
class PhotoSelect: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let CEILID = "cellid"
    let HEADERID = "headerid"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: CEILID)
        collectionView?.register(SelectedImg.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HEADERID)
        SetUpNavButtons()
        Photoselection()
        
        
        
    }
    var Image:UIImage?
    var Images = [UIImage]()
    var Assets = [PHAsset]()
    func Photoselection(){
        DispatchQueue.global().async {
            let Fetchoptions = PHFetchOptions()
            let SortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
            Fetchoptions.sortDescriptors = [SortDescriptor]
            Fetchoptions.fetchLimit = 10 // number of photos
            let Photos = PHAsset.fetchAssets(with: .image, options: Fetchoptions)
            Photos.enumerateObjects { (assets, count, stop) in
                let imagemanager = PHImageManager.default() // to retrieve image
                let Targetsize = CGSize(width: 200, height: 200)
                let Options = PHImageRequestOptions()
                Options.isSynchronous = true
                imagemanager.requestImage(for: assets, targetSize: Targetsize, contentMode: .aspectFit, options: Options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        self.Images.append(image)
                        self.Assets.append(assets)
                        if self.Image == nil{
                            
                            self.Image = image
                        }
                    }
                    if count == Photos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()

                        }
                        
                        
                        
                    }
                    
                })
                
            }
            
        }
    
            
        
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     Image = Images[indexPath.item]
        collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CEILID, for: indexPath) as! PhotoSelectorCell
        
        Cell.CellImage.image = Images[indexPath.item]
        return Cell
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((view.frame.width)-3)/4
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADERID, for: indexPath) as! SelectedImg
        if let Img = Image{
            if let index = Images.index(of: Img){
            let SelectedAssets = Assets[index]
            let targetsize = CGSize(width: 600, height: 600)
        let ImgManager = PHImageManager.default()
                ImgManager.requestImage(for: SelectedAssets, targetSize: targetsize, contentMode: .default, options: nil) { (img, info) in
                    Header.CellImage.image = img
                }
            }}
        Header.CellImage.image = Image
        return Header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    func SetUpNavButtons(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(HandleCancelBtn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(HandleNextBtn))
        navigationController?.navigationBar.tintColor = .black
        
    }
    @objc func HandleNextBtn(){
        print("Cool")
    }
    
    @objc func HandleCancelBtn(){
        dismiss(animated: true, completion: nil)
    }

}
