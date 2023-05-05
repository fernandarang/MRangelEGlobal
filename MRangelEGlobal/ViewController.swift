//
//  ViewController.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 26/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var MyView: UIView!
    @IBOutlet weak var MyButton: UIButton!
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var authenticationviewmodel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userField.text = "fernanda"
        passwordField.text = "231200"
        stylestoView()
        
        MyView.layer.cornerRadius = 16
        
        MyView.layer.shadowColor = UIColor.black.cgColor
        MyView.layer.shadowOffset = CGSize(width: 0, height: 2)
        MyView.layer.shadowOpacity = 0.4
        MyView.layer.shadowRadius = 5
        
        MyButton.layer.cornerRadius = 10
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = MyButton.bounds
        //radientLayer.colors = [UIColor(named: "cyan")?.cgColor, UIColor(named: "menosCyan")?.cgColor] // los colores del gradiente
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // punto de inicio del gradiente
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5) // punto final del gradiente

        // Agregar gradiente de color al fondo del botón
        MyButton.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func stylestoView(){
            if passwordField.text != nil{
                passwordField.isSecureTextEntry = true
            }
        }
    
        func alertfalselogin(){
            let alert = UIAlertController(title: nil, message: "Ingrese credenciales validas", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            self.present(alert, animated: true)
        }
    
        func gettoken(){
            guard let usertext = userField.text, passwordField.text != nil, userField.text != "" else{
                userField.backgroundColor = UIColor(named: "vacio")
                userField.placeholder = "Ingresa tu usuario"
                return
            }
            guard let password = passwordField.text, passwordField.text != nil, passwordField.text != "" else{
                passwordField.backgroundColor = UIColor(named: "vacio")
                passwordField.placeholder = "Ingresa tu password"
                return
            }
            let user = MRangelEGlobal.gettoken(nombre: usertext, password: password)
            
            authenticationviewmodel.gettoken(user: user) { Token in
                DispatchQueue.main.async { [self] in
                   // print(Token?.clave ?? "Sin clave", Token?.respuesta ?? "No recibido")
                    if Token == nil || usertext != "fernanda" || password != "231200"{
                        alertfalselogin()
                    }else{
                        
                    }
                }
            }
        }
        
        @IBAction func buttonaction(_ sender: Any) {
            gettoken()
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    
    


}

