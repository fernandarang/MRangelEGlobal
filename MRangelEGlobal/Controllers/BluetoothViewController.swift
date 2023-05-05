//
//  BluetoothViewController.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 27/04/23.
//

import UIKit
import Foundation
import CoreBluetooth

class BluetoothViewController : UIViewController {
    
    
    var centralManager: CBCentralManager!
    var peripherals = [CBPeripheral]()
    var range = 900.0 // Rango en metros
    
    
    @IBOutlet weak var tableViewDevices: UITableView!
    
    let tiempoEspera: TimeInterval = 60.0
        
        // Establecer un temporizador para detectar la inactividad del usuario
        var temporizadorInactividad: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        centralManager = CBCentralManager(delegate: self, queue: nil)
        tableViewDevices.register(UINib(nibName: "DeviceCell", bundle: .main), forCellReuseIdentifier: "DeviceCell")
        
        tableViewDevices.delegate = self
        tableViewDevices.dataSource = self
        tableViewDevices.rowHeight = UITableView.automaticDimension
        
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
    
}
extension BluetoothViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        
        let peripheral = peripherals[indexPath.row]
        cell.nombre.text = peripheral.name ?? "Unknown"
        cell.identificador.text = "\(peripheral.identifier.uuidString) (\(peripheral.rssi ?? 0) dBm)"
        cell.identificador.numberOfLines = 0
        
        return cell
    }
    
}

extension BluetoothViewController : CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            let scanOptions = [CBCentralManagerScanOptionAllowDuplicatesKey: false]
            centralManager.scanForPeripherals(withServices: nil, options: scanOptions)
        }else{
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                        
                    let alert = UIAlertController(title: "Bluetooth OFF", message: "Power on Bluetooth", preferredStyle: .alert)
                    //let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if RSSI.doubleValue < range, let name = peripheral.name {
            if !peripherals.contains(peripheral) {
                peripherals.append(peripheral)
            }
        }
        tableViewDevices.reloadData()
    }
    
    
    
}


