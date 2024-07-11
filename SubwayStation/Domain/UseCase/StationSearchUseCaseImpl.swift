//
//  StationSearchUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

import RxSwift

final class StationSearchUseCaseImpl: StationSearchUseCase {
    private let stationRepository: StationSearchRepository
    
    init(stationRepository: StationSearchRepository) {
        self.stationRepository = stationRepository
    }
    
    func excute(by StationName: String) -> Single<StationList> {
        return self.stationRepository.fetchStationInfo(by: StationName)
    }
}
