//
//  StationRepository.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

import RxSwift

protocol StationSearchRepository {
    func fetchStationInfo(by stationName: String) -> Single<StationList>
}
