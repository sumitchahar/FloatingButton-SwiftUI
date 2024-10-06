//  UserListModeView.swift
//  ListWithFloatingButton
//  Created by Sumit on 24/07/24.

import Foundation

class UserListModelView:ObservableObject {
    
  @Published  var userListModel:[UserListModel] = []
    
    init() {
        guard let feedsUrl = Bundle.main.url(forResource: "JsonFile", withExtension: "json") else {
            return
        }
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = try? Data(contentsOf: feedsUrl) else {
            return
        }
        
        do {
            self.userListModel = try decoder.decode([UserListModel].self, from: data)
        } catch {
            print(error)
        }
    }
    
 }
