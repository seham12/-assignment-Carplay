//
//  favorite.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 03/06/1445 AH.
//

import Foundation
struct FavoriteModel: Codable , Identifiable {
    var id :UUID
    var userId:String
    var title:String
    var author:String
    var dateOfPublish:String
    var article:String
    var image:String
}
