//
//  MenuViewController.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 28/04/23.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var MyView: UIView!
    
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var edadField: UITextField!
    
    let tiempoEspera: TimeInterval = 60.0
        
        // Establecer un temporizador para detectar la inactividad del usuario
        var temporizadorInactividad: Timer?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyView.layer.cornerRadius = 16
        
        MyView.layer.shadowColor = UIColor.black.cgColor
        MyView.layer.shadowOffset = CGSize(width: 0, height: 2)
        MyView.layer.shadowOpacity = 0.4
        MyView.layer.shadowRadius = 5
        // Do any additional setup after loading the view.
        
        iniciarTemporizador()
    }
    
    // Inicio
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            
            // Reiniciar el temporizador cada vez que el usuario realiza una acción
            reiniciarTemporizador()
        }
        
        func iniciarTemporizador() {
            temporizadorInactividad = Timer.scheduledTimer(withTimeInterval: tiempoEspera, repeats: false, block: { [weak self] _ in
                // Redirigir al usuario a la página de inicio de sesión
                //self?.irAPaginaDeInicioSesion()
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    func reiniciarTemporizador() {
            temporizadorInactividad?.invalidate()
            iniciarTemporizador()
        }
    
    // Fin
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func EnviarInfoBtn(_ sender: UIButton) {
        
        guard let edad = edadField.text, edad != ""  else{
            edadField.placeholder = "Ingresa tu edad.."
            return
        }
        
        guard let nombre = nombreField.text, nombre != "" else{
            nombreField.placeholder = "Ingresa tu nombre.."
            return
        }
        
        let usuarioData = UsuarioModel(nombre: nombre, edad: edad)
        
        LoadData(usuarioData)
        
    }
    
    func LoadData(_ usuarioData : UsuarioModel){
        
        encriptar.viewModel.PostValidateData(usuarioData) { dataResponse, error in
            if let dataResponse = dataResponse, error == nil{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        
                        if encriptar.dataSaveViewModel.AddClave(dataResponse.clave!){
                            print("Save..")
                        }
                        // Crear una instancia de UIAlertController con estilo "alert"
                        let alert = UIAlertController(title: dataResponse.respuesta, message: encriptar.desencriptarAES256(cadenaEncriptada: dataResponse.clave!, claveSecreta: "FVOTFTs1vGc1UjadBAVNeUKmr2RgHR55"), preferredStyle: .alert)

                        // Crear una acción "OK" para el alert
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.nombreField.text = ""
                        self.edadField.text = ""
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else if let error = error{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        
                        
                        // Crear una instancia de UIAlertController con estilo "alert"
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
