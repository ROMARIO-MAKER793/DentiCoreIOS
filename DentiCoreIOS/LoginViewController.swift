//
//  LoginViewController.swift
//  DentiCoreIOS
//
//  Created by XCODE on 18/08/26.
//

import UIKit

struct LoginRequest: Codable {
    let dni: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
    let rol: String
}

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldDNI: UITextField!
    
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        guard let dni = textFieldDNI.text,
                  let password = textFieldPassword.text,
                  !dni.isEmpty,
                  !password.isEmpty else {
                return
            }
    }
    
    
    @IBAction func btnCancelar(_ sender: Any) {
        textFieldDNI.text = ""
        textFieldPassword.text = ""
    }
    
    
}
