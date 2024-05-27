//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by Kiseok on 3/24/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let diContainer: StationDIContainer = .init()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController: UINavigationController = .init()
        
//        di()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.backgroundColor = .systemBackground
        
        let appCoordinator: AppCoordinator = .init(rootViewController: navigationController, diContainer: self.diContainer)
        appCoordinator.start()
        window?.makeKeyAndVisible()
    }
    
//    func di() {
//        //Provider
//        DIContainer.shared.register(Provider(),
//                                    for: Providable.self)
//        let provider = DIContainer.shared.resolve(Providable.self)!
//
//        //Repositories
//        DIContainer.shared.register(StationSearchRepositoryImpl(provider: provider),
//                                    for: StationSearchRepository.self)
//        DIContainer.shared.register(StationArrivalRepositoryImpl(provider: provider),
//                                    for: StationArrivalRepository.self)
//        let stationSearchRepositoryImpl = DIContainer.shared.resolve(StationSearchRepository.self)!
//        let stationArrivalRepositoryImpl = DIContainer.shared.resolve(StationArrivalRepository.self)!
//        
//        //UseCases
//        DIContainer.shared.register(StationSearchUseCase(stationRepository: stationSearchRepositoryImpl),
//                                    for: StationSearchUseCase.self)
//        DIContainer.shared.register(StationArrivalUseCase(repository: stationArrivalRepositoryImpl),
//                                    for: StationArrivalUseCase.self)
//        
//        //ViewModel
//
//    }
}

