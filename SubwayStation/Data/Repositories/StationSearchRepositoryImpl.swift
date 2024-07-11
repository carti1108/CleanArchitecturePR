//
//  StationRepositoryImpl.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

import RxSwift

final class StationSearchRepositoryImpl: StationSearchRepository {
    private let provider: Providable
    
    init(provider: Providable) {
        self.provider = provider
    }
    
    func fetchStationInfo(by stationName: String) -> Single<StationList> {
        let stationAPI = StationAPIs.getStationInfo(by: stationName)
        
        return self.provider.request(with: stationAPI)
            .map { $0.toDomain() }
    }
}
