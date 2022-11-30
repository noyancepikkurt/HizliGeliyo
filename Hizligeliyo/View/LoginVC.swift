//
//  ViewController.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 28.11.2022.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
       }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @IBAction func LoginButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toProductListVC", sender: nil)
    }
    
}

