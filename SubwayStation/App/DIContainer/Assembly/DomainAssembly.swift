//
//  DomainAssembly.swift
//  SubwayStation
//
//  Created by Kiseok on 6/24/24.
//

struct DomainAssembly: Assembly {
    func assemble() {
        DIContainer.shared.register(StationSearchUseCase.self) {
            let repository = DIContainer.shared.resolve(StationSearchRepository.self)!
            return StationSearchUseCaseImpl(stationRepository: repository)
        }
        
        DIContainer.shared.register(StationArrivalUseCase.self) {
            let repository = DIContainer.shared.resolve(StationArrivalRepository.self)!
            return StationArrivalUseCaseImpl(repository: repository)
        }
    }
}
