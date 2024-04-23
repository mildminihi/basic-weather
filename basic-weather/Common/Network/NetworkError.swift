//
//  NetworkError.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//

import Foundation

struct ResponseError: Error, Equatable {
    let responseCode: ResponseCode
    let errorMessageTh: String?
    let errorMessageEn: String?
    let httpResponseStatus: Int?
}

enum ResponseCode: Equatable {
    case failure(String?)
    case gatewayFailure(String)
    case networkFailure(String)
    case sessionFailure(String)
    
    func isSystemError() -> Bool {
        switch self {
        case .failure:
            return false
        case .gatewayFailure, .networkFailure, .sessionFailure:
            return true
        }
    }
}
