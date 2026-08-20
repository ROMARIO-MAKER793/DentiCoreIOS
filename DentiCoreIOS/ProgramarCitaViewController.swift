//
//  ProgramarCitaViewController.swift
//  DentiCoreIOS
//
//  Created by XCODE on 19/08/26.
//

import UIKit

struct Especialidad: Codable {
    let id: Int
    let nombre: String
}

struct Odontologo: Codable {
    let apellidos: String
    let dni: String
    let id: Int
    let nombres: String
}

class ProgramarCitaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var especialidades: [Especialidad] = []
    
    var odontologos: [Odontologo] = []

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {

        if pickerView == pickerEspecialidad {
            return especialidades.count
        } else {
            return odontologos.count
        }
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {

        if pickerView == pickerEspecialidad {
            return especialidades[row].nombre
        } else {
            let odontologo = odontologos[row]
            return "\(odontologo.nombres) \(odontologo.apellidos)"
        }
    }
    
    
    @IBOutlet weak var pickerEspecialidad: UIPickerView!
    
    
    @IBOutlet weak var pickerOdontologo: UIPickerView!
    
    
    
    @IBOutlet weak var datePickerFechaHora: UIDatePicker!
    
    
    @IBOutlet weak var textFieldMontoAdelanto: UITextField!
    
    
    @IBOutlet weak var textFieldReferenciaAdelanto: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerEspecialidad.delegate = self
        pickerEspecialidad.dataSource = self
        
        pickerOdontologo.delegate = self
        pickerOdontologo.dataSource = self
        
        cargarEspecialidades()
        cargarOdontologos()

        
    }
    
    
    func cargarEspecialidades() {

        guard let url = URL(
            string: "http://localhost:8080/api/v1/catalogo/especialidades"
        ) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print("Error al cargar especialidades: \(error)")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let respuesta = try JSONDecoder().decode(
                    [Especialidad].self,
                    from: data
                )

                DispatchQueue.main.async {
                    self.especialidades = respuesta
                    self.pickerEspecialidad.reloadAllComponents()
                }

            } catch {
                print("Error al leer especialidades: \(error)")

                if let texto = String(data: data, encoding: .utf8) {
                    print("Respuesta backend: \(texto)")
                }
            }

        }.resume()
    }
    
    
    func cargarOdontologos() {

        guard let url = URL(
            string: "http://localhost:8080/api/v1/usuarios/odontologos/activos"
        ) else {
            return
        }

        guard let token = UserDefaults.standard.string(
            forKey: "jwtToken"
        ) else {
            print("No existe token JWT")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("STATUS ODONTOLOGOS:", httpResponse.statusCode)
            }

            print(
                "TOKEN LEIDO:",
                UserDefaults.standard.string(forKey: "jwtToken") ?? "SIN TOKEN"
            )
            
            if let error = error {
                print("Error al cargar odontólogos: \(error)")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let respuesta = try JSONDecoder().decode(
                    [Odontologo].self,
                    from: data
                )

                DispatchQueue.main.async {
                    self.odontologos = respuesta
                    self.pickerOdontologo.reloadAllComponents()
                }

            } catch {
                print("Error al leer odontólogos: \(error)")

                if let texto = String(data: data, encoding: .utf8) {
                    print("Respuesta backend: \(texto)")
                }
            }

        }.resume()
    }
    
    @IBAction func btnConfirmarCita(_ sender: Any) {
    }
    
    
    @IBAction func btnCancelarCita(_ sender: Any) {
    }
    
}
