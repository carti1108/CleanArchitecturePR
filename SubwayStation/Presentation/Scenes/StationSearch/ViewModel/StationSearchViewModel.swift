//
//  StationSearchViewModel.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

//protocol StationSearchViewModelActions {
//    func showStationDetail(_ station: StationDetail)
//}

import RxSwift

final class StationSearchViewModel {
    private let useCase: StationSearchUseCase
    
    private(set) var stations: BehaviorSubject<[StationDetail]> = .init(value: [])
    
    init(useCase: StationSearchUseCase) {
        self.useCase = useCase
    }
    
    func requestStationInfo(by stationName: String) -> Single<[StationDetail]> {
        return useCase.excute(by: stationName)
            .map({ stationList in
                return stationList.stations
            })
            .do { [weak self] result in
                guard let self else { return }
                
                self.stations.onNext(result)
            }
    }
}
