//
//  Provider.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

import Foundation
import RxSwift

protocol Providable {
    func request<R: Decodable, E: RequestableAndResponsable>(with endPoint: E) -> Single<R> where E.Response == R
    
    func request(with url: URL) -> Single<Data>
}
