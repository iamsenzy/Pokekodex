//
//  APIManer.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import Foundation
import Combine

class APIManager {
    
    private var subscriber = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void )  {
    
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .removeDuplicates()
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { (resultArr) in
                completion(.success(resultArr))
            }
            .store(in: &subscriber)
    }
}

