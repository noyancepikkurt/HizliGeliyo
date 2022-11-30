//
//  LogOutViewController.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 28.11.2022.
//

import UIKit

class LogOutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    @IBAction func LogOutButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
    

}
