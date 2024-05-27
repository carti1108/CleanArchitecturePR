//
//  DIContainer.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

import UIKit

final class StationDIContainer: StationSearchCoordinatorDependencies {
    
    func makeProvider() -> Providable {
        return Provider()
    }
    
    // MARK: Repositories
    func makeStationSearchRepository() -> StationSearchRepository {
        return StationSearchRepositoryImpl(provider: makeProvider())
    }
    
    func makeStationArrivalRepository() -> StationArrivalRepository {
        return StationArrivalRepositoryImpl(provider: makeProvider())
    }
    
    // MARK: UseCases
    func makeStationSearchUseCase() -> StationSearchUseCase {
        return StationSearchUseCaseImpl(stationRepository: makeStationSearchRepository())
    }
    
    func makeStationArrivalUseCase() -> StationArrivalUseCase {
        return StationArrivalUseCaseImpl(repository: makeStationArrivalRepository())
    }
    
    // MARK: StationSearch
    func makeStationSearchViewModel(actions: StationSearchViewModelActions) -> StationSearchViewModel {
        return StationSearchViewModel(
            useCase: makeStationSearchUseCase(),
            actions: actions
        )
    }
    
    func makeStationSearchViewController(actions: StationSearchViewModelActions) -> StationSearchViewController {
        return StationSearchViewController(viewModel: makeStationSearchViewModel(actions: actions))
    }
    
    // MARK: StationDetail
    func makeStationDetailViewModel(station: StationDetail) -> StationDetailViewModel {
        return StationDetailViewModel(station: station, useCase: makeStationArrivalUseCase())
    }
    
    func makeStationDetailViewController(station: StationDetail) -> StationDetailViewController {
        return StationDetailViewController(viewModel: makeStationDetailViewModel(station: station))
    }
    
    func makeStationSearchCoordinator(navigationController: UINavigationController) -> StationSearchCoordinator {
        return StationSearchCoordinator(
            presenter: navigationController,
            dependencies: self
        )
    }
}
