//
//  StationSearchViewModel.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

struct StationSearchViewModelActions {
    let showStationDetail: (StationDetail) -> Void
}

final class StationSearchViewModel {
    private let useCase: StationSearchUseCase
    private let actions: StationSearchViewModelActions
    
    private(set) var stations: Observable<[StationDetail]> = .init([])
    
    init(useCase: StationSearchUseCase, actions: StationSearchViewModelActions) {
        self.useCase = useCase
        self.actions = actions
    }
    
    func requestStationInfo(by stationName: String) {
        useCase.excute(by: stationName) { result in
            switch result {
            case .success(let data):
                self.stations.value = data.stations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didSelectRow(station: StationDetail) {
        self.actions.showStationDetail(station)
    }
}
