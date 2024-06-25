//
//  DataAssembly.swift
//  SubwayStation
//
//  Created by Kiseok on 6/24/24.
//

struct DataAssembly: Assembly {
    func assemble() {
        DIContainer.shared.register(Providable.self) {
            return Provider()
        }
        
        DIContainer.shared.register(StationSearchRepository.self) {
            let provider = DIContainer.shared.resolve(Providable.self)!
            return StationSearchRepositoryImpl(provider: provider)
        }
        
        DIContainer.shared.register(StationArrivalRepository.self) {
            let provider = DIContainer.shared.resolve(Providable.self)!
            return StationArrivalRepositoryImpl(provider: provider)
        }
    }
}
