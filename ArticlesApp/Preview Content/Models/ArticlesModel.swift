//
//  ArticlesModel.swift
//  ArticlesApp



import Foundation
struct ArticlesModel: Codable , Identifiable {
    var id :UUID
    var title:String
    var description: String
    var author: String
    var dateOfPublish:String
    var article:String
    var image:String
}
