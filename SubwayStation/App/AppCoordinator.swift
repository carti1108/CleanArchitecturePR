//
//  AppCoordinator.swift
//  SubwayStation
//
//  Created by Kiseok on 5/2/24.
//

import UIKit

final class AppCoordinator {
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let stationSearchCoordinator = DIContainer.shared.resolve(StationSearchCoordinator.self, argument: self.rootViewController)!
        stationSearchCoordinator.start()
    }
}
