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

        let loginRequest = LoginRequest(
            dni: dni,
            password: password
        )

        guard let url = URL(
            string: "http://localhost:8080/api/v1/auth/login"
        ) else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
        } catch {
            print("Error al convertir JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error de conexión: \(error)")
                return
            }

            guard let data = data else {
                return
            }

            do {

                let loginResponse = try JSONDecoder().decode(
                    LoginResponse.self,
                    from: data
                )

                print("LOGIN CORRECTO")
                print("ROL: \(loginResponse.rol)")
                print("TOKEN: \(loginResponse.token)")

            } catch {
                print("Error al leer respuesta: \(error)")

                if let respuesta = String(data: data, encoding: .utf8) {
                    print("Respuesta backend: \(respuesta)")
                }
            }

        }.resume()
    }
    
    
    @IBAction func btnCancelar(_ sender: Any) {
        textFieldDNI.text = ""
        textFieldPassword.text = ""
    }
    
    
}
