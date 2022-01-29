//
//  ApiService.swift
//  ApsiyonDemo
//
//  Created by Metilli on 29.01.2022.
//

import Foundation
import Alamofire

struct ApiService{
    
    static func fetchPopulerMovies(page: Int,completion: @escaping (Result<PopulerMovies, Error>) -> Void) {
        let urlString = Constants.ApiService.moviePopulerUrl + "&page=\(page)"
        guard let url = URL(string: urlString) else {return}
        
        AF.request(url).validate().responseDecodable(of: PopulerMovies.self) { response in
            if let safeError = response.error{
                if Reachability.isConnectedToNetwork(){
                    completion(.failure(safeError))
                    return
                }else{
                    // Alamofire automatically cache data. But if alamofire throws error, this code block will try to get data from core data.
                    let cachedResults = CoreDataService.fetchPopulerMovies()
                    completion(.success(cachedResults))
                    return
                }
            }
            guard let populerMovies = response.value else { return }
            CoreDataService.saveContext(movies: populerMovies)
            completion(.success(populerMovies))
            return
        }
    }
    
}
