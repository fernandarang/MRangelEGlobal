//
//  AuthenticationViewModel.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 26/04/23.
//

import Foundation

class AuthenticationViewModel {
    //var Gettoken = MRangelEGlobal.gettoken()
    
    
    func gettoken(user : gettoken, token : @escaping(getokenvalue?)->Void){
           let decoder = JSONDecoder()
        let baseurl = "https://60fad2cf-9dce-4a29-ad1c-7347712b6086.mock.pstmn.io/Token"
           //let baseurl = "https://b90fa279-d248-4cf9-82a6-f3cdcb16a64d.mock.pstmn.io/login"
           let url = URL(string: baseurl)
           var urlrequest = URLRequest(url: url!)
           urlrequest.httpMethod = "POST"
           urlrequest.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
           urlrequest.httpBody = try! JSONEncoder().encode(user)
           let urlsession = URLSession.shared
           urlsession.dataTask(with: urlrequest){ [self]data, error, response in
               if let safedata = data{
                   let json = jsondecoer(data : data!)
                   token(json)
               }
           } .resume()
       }
    
       func jsondecoer(data: Data)->getokenvalue?{
           var decodable = JSONDecoder()
           do{
               let request = try decodable.decode(getokenvalue.self, from: data)
               let gettoken = getokenvalue(respuesta: request.respuesta, clave: request.clave)
                   return gettoken
           }
           catch let error{
               print(error.localizedDescription)
               return nil
           }
       }
    
    
    
    func PostAuthorization(_ usuario : gettoken, _ response : @escaping(getokenvalue?, Error?) -> Void){
        encriptar.urlComponents.scheme = "https"
        //encriptar.urlComponents.host = "b90fa279-d248-4cf9-82a6-f3cdcb16a64d.mock.pstmn.io"
        encriptar.urlComponents.host = "60fad2cf-9dce-4a29-ad1c-7347712b6086.mock.pstmn.io"
        //encriptar.urlComponents.path = "/Authentication/Login"
        encriptar.urlComponents.path = "/Token"
        
        if let url = encriptar.urlComponents.url {
            do{
                encriptar.jsonEncoder.outputFormatting = .prettyPrinted
                
                let jsonBodyData = try encriptar.jsonEncoder.encode(usuario)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonBodyData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                encriptar.urlSession.dataTask(with: request) { data, res, error in
                    
                    if let data = data, let httpResponse = res as? HTTPURLResponse, error == nil{
                        if 200...400 ~=  httpResponse.statusCode {
                            do{
                                let resData = try encriptar.jsonDecoder.decode(getokenvalue.self, from: data)
                                response(resData, error)
                            }catch let error{
                                response(nil, error)
                            }
                            
                        }
                    }else if let error = error{
                        response(nil, error)
                    }
                    else{
                        response(nil, nil)
                    }
                }.resume()
                
                
            }catch let error{
                response(nil, error)
            }
            
            
        }
    }
    
    
    
    func PostValidateData(_ usuarioData : UsuarioModel, _ response : @escaping(getokenvalue?, Error?) -> Void){
            encriptar.urlComponents.scheme = "https"
            //encriptar.urlComponents.host = "b90fa279-d248-4cf9-82a6-f3cdcb16a64d.mock.pstmn.io"
        encriptar.urlComponents.host = "60fad2cf-9dce-4a29-ad1c-7347712b6086.mock.pstmn.io"
            //encriptar.urlComponents.path = "/Validate"
        encriptar.urlComponents.path = "/Token"
            
            if let url = encriptar.urlComponents.url {
                do{
                    encriptar.jsonEncoder.outputFormatting = [ .prettyPrinted]
                    
                    let jsonBodyData = try encriptar.jsonEncoder.encode(usuarioData)
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = jsonBodyData
                    
                    encriptar.urlSession.dataTask(with: request) { data, res, error in
                        
                        if let data = data, let httpResponse = res as? HTTPURLResponse, error == nil{
                            if 200...400 ~=  httpResponse.statusCode {
                                do{
                                    let resData = try encriptar.jsonDecoder.decode(getokenvalue.self, from: data)
                                    response(resData, error)
                                }catch let error{
                                    response(nil, error)
                                }
                                
                            }
                        }else if let error = error{
                            response(nil, error)
                        }
                        else{
                            response(nil, nil)
                        }
                    }.resume()
                    
                    
                }catch let error{
                    response(nil, error)
                }
            }
        }
    
    
}
