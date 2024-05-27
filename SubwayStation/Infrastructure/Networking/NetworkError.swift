//
//  NetworkError.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidRequest
    case decodedFailure
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "잘못된 URL입니다."
        case .invalidResponse:
            "잘못된 Response입니다."
        case .invalidData:
            "잘못된 Data입니다."
        case .invalidRequest:
            "잘못된 Request입니다."
        case .decodedFailure:
            "decode를 실패했습니다."
        }
    }
}
