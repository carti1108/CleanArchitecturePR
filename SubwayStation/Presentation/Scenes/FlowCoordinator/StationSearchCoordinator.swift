//
//  StationSearchCoordinator.swift
//  SubwayStation
//
//  Created by Kiseok on 5/2/24.
//

import UIKit

final class StationSearchCoordinator: StationSearchViewControllerDelegate {
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let viewModel = DIContainer.shared.resolve(StationSearchViewModel.self)!
        let viewController = StationSearchViewController(viewModel: viewModel, delegate: self)
        
        self.presenter.pushViewController(viewController, animated: true)
    }
    
    func showStationDetailView(_ station: StationDetail) {
        let viewModel = DIContainer.shared.resolve(StationDetailViewModel.self, argument: station)!
        let viewController = StationDetailViewController(viewModel: viewModel)
        
        self.presenter.pushViewController(viewController, animated: true)
    }
}
