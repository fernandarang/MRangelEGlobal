//
//  InformacionViewModel.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 03/05/23.
//

import Foundation
import CoreData

class InformacionViewModel{
    func AddClave(_ clave : String) -> Bool{
        do {
            let newFavorite = NSEntityDescription.insertNewObject(forEntityName: "Respuesta", into: encriptar.context)
            newFavorite.setValue(clave, forKey: "clave")
            try encriptar.context.save()
            return true
        } catch _ as NSError{
            return false
        }
    }
    
    func GetAllClave() -> [Respuesta] {
        
        let request = NSFetchRequest<Respuesta>(entityName: "Respuesta")
        
        var claves: [Respuesta] = []
        do {
            claves = try encriptar.context.fetch(request)
        } catch {
            print("Error al obtener registros: \(error)")
        }
        
        return claves
    }
}
