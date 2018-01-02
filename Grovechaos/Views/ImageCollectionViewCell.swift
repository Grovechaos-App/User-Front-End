//
//  ImageCollectionViewCell.swift
//  Grovechaos
//
//  Created by Hayne Park on 11/20/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

