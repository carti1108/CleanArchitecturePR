//
//  StationArrivalUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 4/29/24.
//

import RxSwift

final class StationArrivalUseCaseImpl: StationArrivalUseCase {
    private let repository: StationArrivalRepository
    
    init(repository: StationArrivalRepository) {
        self.repository = repository
    }
    
    func excute(by stationName: String) -> Single<StationArrival> {
        return self.repository.fetchStationArrival(by: stationName)
    }
}
