//
//  StationSearchCoordinator.swift
//  SubwayStation
//
//  Created by Kiseok on 5/2/24.
//

import UIKit

protocol StationSearchCoordinatorDependencies {
    func makeStationSearchViewController(actions: StationSearchViewModelActions) -> StationSearchViewController
    func makeStationDetailViewController(station: StationDetail) -> StationDetailViewController
}

final class StationSearchCoordinator {
    private let presenter: UINavigationController
    private let dependencies: StationSearchCoordinatorDependencies
    
    init(presenter: UINavigationController, dependencies: StationSearchCoordinatorDependencies) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = StationSearchViewModelActions(showStationDetail: showStationDetail)
        let viewController = self.dependencies.makeStationSearchViewController(actions: actions)
        
        self.presenter.pushViewController(viewController, animated: true)
    }
    
    func showStationDetail(station: StationDetail) {
        let viewController = self.dependencies.makeStationDetailViewController(station: station)
        
        self.presenter.pushViewController(viewController, animated: true)
    }
}
