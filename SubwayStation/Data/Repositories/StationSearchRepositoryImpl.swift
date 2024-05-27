//
//  StationRepositoryImpl.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

final class StationSearchRepositoryImpl: StationSearchRepository {
    private let provider: Providable
    
    init(provider: Providable) {
        self.provider = provider
    }
    
    func fetchStationInfo(by stationName: String, completion: @escaping (Result<StationList, Error>) -> Void) {
        let stationAPI = StationAPIs.getStationInfo(by: stationName)
        
        provider.request(with: stationAPI) { result in
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//providable 프로토콜로 의존성 주입
