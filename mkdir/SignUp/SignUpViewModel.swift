//
//  SignUpViewModel.swift
//  Auth
//
//  Created by Apple on 08/11/23.
//
enum HttpMethod{
    static let post="POST"
    static let get="GET"
    static let put="PUT"
}
import Foundation
class SignUpViewModel:ObservableObject{
    
    @Published var signUp:SignUpResponse?
    func signUp(email:String,password:String){
        let requestBody=SignUpModel(email: email, password: password)
//        let requestBody=["email":email, "password":password]
        let url=URL(string: "http://localhost:8000/signup")
        guard let urlRequest=url else {return}
        var request=URLRequest(url: urlRequest)
//        guard let data=jsonDecoder(payload: requestBody) else {return}
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let data=encode(modelToEncode: requestBody) else {return}
        request.httpMethod = HttpMethod.post
        request.httpBody = data
        let dataTask=URLSession.shared.dataTask(with: request){data, response, error in
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode==200{
                guard let data=data else {return}
                let jsonDecoder=JSONDecoder()
                do {
                    let data=try jsonDecoder.decode(SignUpResponse.self, from: data)
                    self.signUp=data
                    print(self.signUp as Any, "sign up data")
                } catch {
                    return
                }
            }
        }
        dataTask.resume()
        
    }
    
    func encode<T: Encodable>(modelToEncode: T) -> Data? {
        let encodedData = try? JSONEncoder().encode(modelToEncode)
        return encodedData
    }
    
    func jsonDecoder(payload:[String:String])->Data?{
        let encodeFata=try? JSONSerialization.data(withJSONObject: payload)
        return encodeFata
    }
}
