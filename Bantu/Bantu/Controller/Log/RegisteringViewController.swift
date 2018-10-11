//
//  RegisteringViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class RegisteringViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.buttonDesign()
    }
    
    func createOkAlert(title: String, message: String, onComplete: @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            onComplete()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createNewUser(){
        
    }
    
    @IBAction func registerButtonClicked() {
        if (self.fullNameTextField.text == "" || self.phoneTextField.text == "" || self.emailTextField.text == "" || self.passwordTextField.text == "" || self.confirmPasswordTextField.text == ""){
            self.createOkAlert(title: "Gagal Daftar", message: "Mohon isi semua field!"){}
        }
        else if (self.passwordTextField.text != self.confirmPasswordTextField.text){
            self.createOkAlert(title: "Daftar Gagal", message: "Konfirmasi kata sandi tidak sesuai!"){}
        }
        else{
            self.createNewUser()
        }
    }
    
    
}
