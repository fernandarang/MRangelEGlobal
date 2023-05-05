//
//  Authentication.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 26/04/23.
//

import Foundation
struct gettoken : Codable{
    var nombre : String
    var password : String
    
    init(nombre: String, password: String) {
        self.nombre = nombre
        self.password = password
    }
    init(){
        self.nombre = ""
        self.password = ""
    }
}
struct getokenvalue : Codable{
    var respuesta: String
    var clave : String?
}

struct Uservalue : Codable{
    var val_User : Bool
}
