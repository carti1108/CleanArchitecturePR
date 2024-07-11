//
//  StationDetailViewModel.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

import Foundation

final class StationDetailViewModel {
    
    private let useCase: StationArrivalUseCase
    let station: StationDetail
    
    init(station: StationDetail, useCase: StationArrivalUseCase) {
        self.station = station
        self.useCase = useCase
    }
    
    
    @objc func requestStationArrival() {
        self.useCase.excute(by: station.stationName) { result in
            switch result {
            case .success(let data):
                self.realTimeArrivalList.value = data.realtimeArrivalList
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
