//
//  WeightViewController.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/6/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lightLabel: UILabel!
    @IBOutlet var heavyLabel: UILabel!
    @IBOutlet var lightImageView: UIImageView!
    @IBOutlet var heavyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.lightImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished) in
            UIView.animate(withDuration: 0.4, animations: {
                self.lightImageView.transform = CGAffineTransform.identity
            }) { (finished) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.heavyImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }) { (finished) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.heavyImageView.transform = CGAffineTransform.identity
                    })
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
