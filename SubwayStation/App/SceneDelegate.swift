//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by Kiseok on 3/24/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var injector: DependencyInjector?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController: UINavigationController = .init()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.backgroundColor = .systemBackground
        
        self.injector = DependencyInjector()
        self.injector?.assemble([DataAssembly(), DomainAssembly(), PresentationAssembly()])
        
        let appCoordinator: AppCoordinator = .init(rootViewController: navigationController)
        appCoordinator.start()
        window?.makeKeyAndVisible()
    }
}

