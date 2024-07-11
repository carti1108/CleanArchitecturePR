//
//  StationArrivalUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 5/27/24.
//

import RxSwift

protocol StationArrivalUseCase {
    func excute(by stationName: String) -> Single<StationArrival>
}
