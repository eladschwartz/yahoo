//
//  Api.swift
//  yahoo!
//
//  Created by elad schwartz on 03/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import Foundation

class ApiServer {
    
    init(){}
     
    let apiBase = "https://us-central1-cpai-interviews.cloudfunctions.net/"
  
    func getEventsAndTodos(completion: @escaping (Result<EventToDo, Error>) -> Void) {
         if let url = URL(string: apiBase + "getEventsAndTodos") {
             let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                 if let error = error {
                     print(error.localizedDescription)
                     completion(Result.failure(error))
                 }
                 
                 guard let data = data else { return }
                 do {
                     let decoder = JSONDecoder()
                     decoder.dateDecodingStrategy = .formatted(Utils.shared.dateFormatter)
                     let eventsAndTodo = try decoder.decode(EventToDo.self, from: data)
                     completion(.success(eventsAndTodo))
                 } catch {
                     print(error.localizedDescription)
                     completion(.failure(error))
                 }
             }
             task.resume()
         }
     }
    
    func getUsers(completion: @escaping (Result<Dictionary<String, Dictionary<String, String>>, Error>) -> Void) {
         if let url = URL(string: apiBase + "getUsers") {
             let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                 if let error = error {
                     print(error.localizedDescription)
                     completion(Result.failure(error))
                 }
                 
                 guard let data = data else { return }
                 do {
                     let decoder = JSONDecoder()
                     decoder.dateDecodingStrategy = .formatted(Utils.shared.dateFormatter)
                     let users = try decoder.decode(Dictionary<String, Dictionary<String, String>>.self, from: data)
                     completion(.success(users))
                 } catch {
                     print(error.localizedDescription)
                     completion(.failure(error))
                 }
             }
             task.resume()
         }
     }
}
