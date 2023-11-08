//
//  SignUpModel.swift
//  Auth
//
//  Created by Apple on 08/11/23.
//

import Foundation

struct SignUpModel:Codable{
    let email:String
    let password:String
}

struct SignUpResponse:Codable{
    let is_error:Bool
    let message:String
}
