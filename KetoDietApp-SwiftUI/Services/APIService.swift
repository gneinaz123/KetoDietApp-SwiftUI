//
//  APIService.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import Foundation

class APIService : RecipeServiceProtocol{
    static let shared = APIService()
    private init() {}
    
    func fetchRecipes(for filters: [Filter], completion: @escaping ([RecipeDetails]) -> Void){
        guard let filter = filters.first else{
            completion([])
            return
        }
        let field = filter.category.apiField
        let query = "\(field) = \(filter.min)-\(filter.max)g"
        
        guard let url = URL(string: "https://keto-diet.p.rapidapi.com/?\(query)") else{
            completion([])
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("43bc551287msh3b900558597b0c0p1d9df2jsnef549a6444c2", forHTTPHeaderField: "X-Rapidapi-Key")
        request.setValue("keto-diet.p.rapidapi.com", forHTTPHeaderField: "X-Rapidapi-Host")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                completion([])
                return
            }
            do {
                let recipes = try JSONDecoder().decode([RecipeDetails].self, from: data)
                DispatchQueue.main.async{
                    completion(recipes)
                }
            } catch{
                print("Decoding error: \(error)")
                completion([])
            }
            
        }.resume()
        
    }
}
