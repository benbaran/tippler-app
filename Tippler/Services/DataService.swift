//
//  DataService.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import Foundation

class Business : Decodable {
    
    var id: Int
    var name: String
    var amount: Int
}

enum DataServiceError: Error {
    
    case noDataAvailable
    case cannotProcessData
}

class DataService{
    
    static func getBusinesses(completion: @escaping(Result<[Business], Error>) -> Void){
        
        let urlString = "https://tippler-api-websocket.azurewebsites.net/business";
        
        guard let resourceUrl = URL(string: urlString) else {
            
            return
        }
        
        #if DEBUG
        print("Calling \(urlString)");
        #endif
        
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
            
            guard let jsonData = data else {
                
                completion(.failure(DataServiceError.noDataAvailable))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                
                let response = try decoder.decode([Business].self, from: jsonData)
                
                let businesses = response
                
                #if DEBUG
                print("Sucessfully retrieved business data.");
                #endif
                
                completion(.success(businesses))
            }
            catch{
                
                completion(.failure(DataServiceError.cannotProcessData))
            }
            
        }
        
        dataTask.resume()
    }
}
