//
//  UsersModel.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import Foundation

struct UsersModel: Identifiable, Codable{
    var id: UUID
    var email: String
    var password: String
    var name: String
    
}
