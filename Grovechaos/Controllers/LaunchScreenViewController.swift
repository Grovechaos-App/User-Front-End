//
//  LaunchScreenViewController.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/7/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase

class LaunchScreenViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var launchImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 0.4, animations: {
            self.launchImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) in
            UIView.animate(withDuration: 0.4, animations: {
                self.launchImageView.transform = CGAffineTransform.identity
            })
        }
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.frame = CGRect(x: 15, y : 24, width: view.frame.width - 30, height: 45)
        let newCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 70)
        loginButton.center = newCenter
        view.addSubview(loginButton)
        loginButton.delegate = self
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        guard let accessToken = AccessToken.current else {
            print("Failed to get access token")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
        
        // Perform login by calling Firebase APIs
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            // Present the main view
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
            
        })
    }

    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        // Logout handling code here
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
