//
//  EndPoint.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//

import Foundation
import Alamofire

public class Endpoint {

    public var method: HTTPMethod
    public var path: String
    public var bodyParameters: [String: Any]

    init(method: HTTPMethod,
         path: String,
         bodyParameters: [String: Any] = [:]) {
        self.method = method
        self.path = path
        self.bodyParameters = bodyParameters
    }
}
