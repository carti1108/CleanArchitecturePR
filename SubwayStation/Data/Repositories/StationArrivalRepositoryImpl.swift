//
//  StationArrivalRepositoryImpl.swift
//  SubwayStation
//
//  Created by Kiseok on 4/29/24.
//

import RxSwift

final class StationArrivalRepositoryImpl: StationArrivalRepository {
    private let provider: Providable
    
    init(provider: Providable) {
        self.provider = provider
    }
    
    func fetchStationArrival(by stationName: String) -> Single<StationArrival> {
        let api = StationAPIs.getStationArrival(by: stationName)
        
        return self.provider.request(with: api)
            .map { $0.toDomain() }
    }
}
