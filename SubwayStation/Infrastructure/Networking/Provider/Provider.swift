//
//  Provider.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

import Foundation
import RxSwift

final class Provider: Providable {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequestableAndResponsable>(with endPoint: E) -> Single<R> where R == E.Response {
        do {
            let urlRequest = try endPoint.getUrlRequest()
            return self.executeRequest(with: urlRequest, dataType: R.self)
        } catch {
            return Single.error(NetworkError.invalidRequest)
        }
    }
    
    func request<R: Decodable>(with url: URL) -> Single<R> {
        let urlRequest = URLRequest(url: url)
        return executeRequest(with: urlRequest, dataType: R.self)
    }
    
    private func executeRequest<R: Decodable>(with urlRequest: URLRequest, dataType: R.Type) -> Single<R> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(NetworkError.unknown))
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                switch self.checkError(with: data, response, error) {
                case .success(let data):
                    do {
                        let data = try JSONDecoder().decode(R.self, from: data)
                        single(.success(data))
                    } catch {
                        single(.failure(NetworkError.decodedFailure))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data, Error> {
        if let error = error {
            return .failure(error)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .failure(NetworkError.invalidResponse)
        }
        
        guard (200...299).contains(response.statusCode) else {
            return .failure(NetworkError.invalidResponse)
        }
        
        guard let data = data else {
            return .failure(NetworkError.invalidData)
        }
        
        return .success(data)
    }
}
