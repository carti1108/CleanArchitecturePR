//
//  EndPoint.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

import Foundation

protocol RequestableAndResponsable: Requestable, Responsable {}

final class EndPoint<R>: RequestableAndResponsable {
    typealias Response = R
    
    var baseURL: String
    var path: String
    var method: HttpMethod
    var queryParameters: Encodable?
    var bodyParameters: Encodable?
    var headers: [String : String]?
    
    init(baseURL: String, path: String = "", method: HttpMethod = .get, queryParameters: Encodable? = nil, bodyParameters: Encodable? = nil, headers: [String : String]? = nil, sampleData: Data? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
}
