//
//  PacienteHomeViewController.swift
//  DentiCoreIOS
//
//  Created by XCODE on 19/08/26.
//

import UIKit

class PacienteHomeViewController: UIViewController {
    
    
    @IBOutlet weak var lblNombrePaciente: UILabel!
    
    
    @IBOutlet weak var lblDNI: UILabel!
    
    
    var dniPaciente:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDNI.text = dniPaciente

        
    }
    
    
    @IBAction func btnProgramarCita(_ sender: Any) {
    }
    
    
    
    @IBAction func btnMisCitas(_ sender: Any) {
    }
    
    
    @IBAction func btnCerrarSesion(_ sender: Any) {
    }
    
}
