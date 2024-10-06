//  UserListModel.swift
//  ListWithFloatingButton
//  Created by Sumit on 24/07/24.

 import Foundation

struct UserListModel:Codable, Hashable {
    var itemId:Int
    var name:String
    var img:String
    var time:String
    var description:String
 }
