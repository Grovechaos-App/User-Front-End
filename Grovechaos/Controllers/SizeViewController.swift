//
//  SizeViewController.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/6/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit

class SizeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var smallLabel: UILabel!
    @IBOutlet var largeLabel: UILabel!
    @IBOutlet var smallImageView: UIImageView!
    @IBOutlet var largeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.smallImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished) in
            UIView.animate(withDuration: 0.4, animations: {
                self.smallImageView.transform = CGAffineTransform.identity
            }) { (finished) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.largeImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }) { (finished) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.largeImageView.transform = CGAffineTransform.identity
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
