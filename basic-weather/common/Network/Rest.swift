//
//  Rest.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//

import Foundation
import Alamofire

final class Rest {
    
    static let shared = Rest()
    private init() {}
    
    func request<T: Decodable>(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, ResponseError>) -> Void) {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "5d1b7f0444msh258c7f0ffa78ea1p1ab8f2jsnd9dfc448653e",
            "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(ResponseError(responseCode: .failure(nil), errorMessageTh: nil, errorMessageEn: nil, httpResponseStatus: nil)))
                }
            }
    }
}
