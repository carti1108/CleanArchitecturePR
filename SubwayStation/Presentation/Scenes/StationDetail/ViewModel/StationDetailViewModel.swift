//
//  StationDetailViewModel.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

import Foundation

final class StationDetailViewModel {
    private var timer: Timer?
    private(set) var realTimeArrivalList: Observable<[RealTimeArrival]> = .init([])
    
    private let useCase: StationArrivalUseCase
    let station: StationDetail
    
    init(station: StationDetail, useCase: StationArrivalUseCase) {
        self.station = station
        self.useCase = useCase
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(
                timeInterval: 10.0,
                target: self,
                selector: #selector(self.requestStationArrival),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
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
