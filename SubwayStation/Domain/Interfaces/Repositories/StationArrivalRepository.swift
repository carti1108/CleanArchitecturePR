//
//  StationDetailRepository.swift
//  SubwayStation
//
//  Created by Kiseok on 4/29/24.
//

import RxSwift

protocol StationArrivalRepository {
    func fetchStationArrival(by stationName: String) -> Single<StationArrival>
}
