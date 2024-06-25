//
//  StationSearchViewModel.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

//protocol StationSearchViewModelActions {
//    func showStationDetail(_ station: StationDetail)
//}

final class StationSearchViewModel {
    private let useCase: StationSearchUseCase
    
    private(set) var stations: Observable<[StationDetail]> = .init([])
    
    init(useCase: StationSearchUseCase) {
        self.useCase = useCase
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
}
