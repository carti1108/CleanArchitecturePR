//
//  Provider.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

import Foundation

protocol Providable {
    func request<R: Decodable, E: RequestableAndResponsable>(with endPoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R
    
    func request<R: Decodable>(with url: URL, completion: @escaping (Result<R, Error>) -> Void)
}
