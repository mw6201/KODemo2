//
//  GalleryItemCollectionViewCell.swift
//  UICollectionView_p1_Swift
//
//  Created by Olga Dalton on 20/11/14.
//  Copyright (c) 2014 Olga Dalton. All rights reserved.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImageView: UITextField!
    
    func setGalleryItem(item:GalleryItem) {
        itemImageView.text = item.itemImage
    }
    
}