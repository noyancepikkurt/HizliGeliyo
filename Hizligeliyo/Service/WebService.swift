//
//  WebService.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 28.11.2022.
//

import Foundation

class WebService {
    
    func downloadInfos(url : URL, completion: @escaping ([ItemsModel]?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let ItemsList = try? JSONDecoder().decode([ItemsModel].self, from: data)
                
                if let ItemsList = ItemsList {
                    completion(ItemsList)
                    
                }
            }
        }.resume()
        
    }
}
