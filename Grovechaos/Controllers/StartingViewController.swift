//
//  StartingViewController.swift
//  Grovechaos
//
//  Created by Hayne Park on 11/20/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewLayout: CustomImageFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let imageName = (indexPath.row % 2 == 0) ? "image1" : "image2"
        
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
