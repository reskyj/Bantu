//
//  imagesCollectionCell.swift
//  Bantu
//
//  Created by Gior Fasolini on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class imagesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollection: UIImageView!
    
    
    func setImages(image: UIImage) {
        self.imageCollection.image = image
    }
    
}
