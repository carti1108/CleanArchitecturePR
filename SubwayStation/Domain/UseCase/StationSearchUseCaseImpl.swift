//
//  StationSearchUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

final class StationSearchUseCaseImpl: StationSearchUseCase {
    private let stationRepository: StationSearchRepository
    
    init(stationRepository: StationSearchRepository) {
        self.stationRepository = stationRepository
    }
    
    func excute(by stationName: String, completion: @escaping (Result<StationList, Error>) -> Void) {
        self.stationRepository.fetchStationInfo(by: stationName) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
