//
//  StationArrivalUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 4/29/24.
//

final class StationArrivalUseCaseImpl: StationArrivalUseCase {
    private let repository: StationArrivalRepository
    
    init(repository: StationArrivalRepository) {
        self.repository = repository
    }
    
    func excute(by stationName: String, completion: @escaping (Result<StationArrival, Error>) -> Void) {
        repository.fetchStationArrival(by: stationName) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
