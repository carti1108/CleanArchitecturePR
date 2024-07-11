//
//  StationDetailViewModel.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

import RxSwift
import Foundation

final class StationDetailViewModel {
    private(set) var realTimeArrivalList: BehaviorSubject<[RealTimeArrival]> = .init(value: [])
    
    private let useCase: StationArrivalUseCase
    let station: StationDetail
    
    init(station: StationDetail, useCase: StationArrivalUseCase) {
        self.station = station
        self.useCase = useCase
    }
    
    func requestStationArrival() -> Single<[RealTimeArrival]> {
        return self.useCase.excute(by: station.stationName)
            .map { $0.realtimeArrivalList }
            .do { [weak self] result in
                guard let self else { return }
                
                self.realTimeArrivalList.onNext(result)
            }
    }
}
