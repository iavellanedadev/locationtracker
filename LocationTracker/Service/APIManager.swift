//
//  APIManager.swift
//  LocationTracker
//
//  Created by Consultant on 4/29/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

typealias PostDataHandler = (Result<ResponseMessage, Error>) -> Void

protocol PostData : AnyObject {
    func postData(_ data: Payload, to url: URL, completion: @escaping PostDataHandler)
}

final class APIManager : PostData {
    func postData(_ data: Payload, to url: URL, completion: @escaping PostDataHandler) {
        var request = URLRequest(url: url)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            request.httpBody = jsonData
            request.httpMethod = "POST"
            
        } catch {
            completion(.failure(error))
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let jsonResp = try JSONDecoder().decode(ResponseMessage.self, from: data)
                    completion(.success(jsonResp))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
