//
//  StationArrivalRepositoryImpl.swift
//  SubwayStation
//
//  Created by Kiseok on 4/29/24.
//

final class StationArrivalRepositoryImpl: StationArrivalRepository {
    private let provider: Providable
    
    init(provider: Providable) {
        self.provider = provider
    }
    
    func fetchStationArrival(by stationName: String, completion: @escaping (Result<StationArrival, Error>) -> Void) {
        let api = StationAPIs.getStationArrival(by: stationName)
        
        provider.request(with: api) { result in
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
