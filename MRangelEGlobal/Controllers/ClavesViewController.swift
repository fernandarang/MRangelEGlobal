//
//  ClavesViewController.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 03/05/23.
//

import UIKit

class ClavesViewController: UIViewController {
    
    @IBOutlet weak var clavesTableView: UITableView!
    
    var respuestas = [Respuesta]()
    
    let tiempoEspera: TimeInterval = 60.0
        
        // Establecer un temporizador para detectar la inactividad del usuario
        var temporizadorInactividad: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clavesTableView.register(UINib(nibName: "ClaveCell", bundle: .main), forCellReuseIdentifier: "ClaveCell")
        clavesTableView.delegate = self
        clavesTableView.dataSource = self
        clavesTableView.rowHeight =  UITableView.automaticDimension

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
        respuestas = encriptar.dataSaveViewModel.GetAllClave()
     
        
        if respuestas.count == 0{
                // Crear una instancia de UIAlertController con estilo "alert"
            let alert = UIAlertController(title: "Sin Información", message: "Primero ingresa tu información", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        clavesTableView.reloadData()
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
extension ClavesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return respuestas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaveCell", for: indexPath) as! ClaveCell
        
        cell.claveLbl.text = respuestas[indexPath.item].clave
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
}
