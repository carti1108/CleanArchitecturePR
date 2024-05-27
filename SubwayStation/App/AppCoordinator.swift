//
//  AppCoordinator.swift
//  SubwayStation
//
//  Created by Kiseok on 5/2/24.
//

import UIKit

final class AppCoordinator {
    private let rootViewController: UINavigationController
    private let diContainer: StationDIContainer
    
    init(rootViewController: UINavigationController, diContainer: StationDIContainer) {
        self.rootViewController = rootViewController
        self.diContainer = diContainer
    }
    
    func start() {
        let stationSearchCoordinator = diContainer.makeStationSearchCoordinator(navigationController: self.rootViewController)
        stationSearchCoordinator.start()
    }
}
