//
//  PresentationAssembly.swift
//  SubwayStation
//
//  Created by Kiseok on 6/24/24.
//

import UIKit

struct PresentationAssembly: Assembly {
    func assemble() {
        DIContainer.shared.register(StationSearchCoordinator.self) { (presenter: UINavigationController) in
            return StationSearchCoordinator(presenter: presenter)
        }
        
        DIContainer.shared.register(StationSearchViewModel.self) {
            let useCase = DIContainer.shared.resolve(StationSearchUseCase.self)!
            return StationSearchViewModel(useCase: useCase)
        }
        
        DIContainer.shared.register(StationDetailViewModel.self) { (station: StationDetail) in
            let useCase = DIContainer.shared.resolve(StationArrivalUseCase.self)!
            return StationDetailViewModel(station: station, useCase: useCase)
        }
    }
}

