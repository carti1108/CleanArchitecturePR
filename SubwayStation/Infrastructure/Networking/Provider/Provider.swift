//
//  Provider.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

import Foundation

final class Provider: Providable {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequestableAndResponsable>(with endPoint: E, completion: @escaping (Result<R, Error>) -> Void) where R == E.Response {
        do {
            let urlRequest = try endPoint.getUrlRequest()
            self.excuteRequest(with: urlRequest, completion: completion)
        } catch {
            completion(.failure(NetworkError.invalidRequest))
        }
    }
    
    func request<R: Decodable>(with url: URL, completion: @escaping (Result<R, Error>) -> Void) {
        let urlRequest = URLRequest(url: url)
        self.excuteRequest(with: urlRequest, completion: completion)
    }
    
    private func excuteRequest<R: Decodable>(with urlRequest: URLRequest, completion: @escaping (Result<R, Error>) -> Void) {
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            self.checkError(with: data, response, error) { result in
                switch result {
                case .success(let data):
                    completion(self.decode(data: data))
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
        }.resume()
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        
        guard (200...299).contains(response.statusCode) else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkError.invalidData))
            return
        }
        
        completion(.success(data))
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            
            return .success(decoded)
        } catch {
            return .failure(NetworkError.decodedFailure)
        }
    }
}
