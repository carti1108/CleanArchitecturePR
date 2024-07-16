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
    var queryParameters: [String: Any]
    var queryParametersEncodable: Encodable?
    var bodyParameters: [String : Any]
    var bodyParametersEncodable: Encodable?
    var headers: [String : String]?
    
    init(baseURL: String, path: String = "", method: HttpMethod = .get, queryParameters: [String: Any] = [:], queryParametersEncodable: Encodable? = nil, bodyParameters: [String: Any] = [:], bodyParametersEncodable: Encodable? = nil, headers: [String : String]? = nil, sampleData: Data? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.bodyParameters = bodyParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.headers = headers
    }
}
