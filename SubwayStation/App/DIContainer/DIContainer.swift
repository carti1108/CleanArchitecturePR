//
//  DIContainer.swift
//  SubwayStation
//
//  Created by Kiseok on 5/20/24.
//

import Foundation

final class DIContainer {
    static let shared: DIContainer = .init()
    
    private var dependencies: [String: Any] = .init()
    
    private init() {}
    
    //MARK: register
    func register<T>(_ type: T.Type, factory: @escaping () -> T, key: String = "") {
        let key = key.isEmpty ? String(describing: type) : key
        self.dependencies[key] = factory
    }
    
    func register<T, Arg>(_ type: T.Type, key: String = "", factory: @escaping (Arg) -> T) {
        let key = key.isEmpty ? String(describing: type) : key
        self.dependencies[key] = factory
    }
    
    //MARK: resolve
    func resolve<T>(_ type: T.Type, key: String = "") -> T? {
        let key = key.isEmpty ? String(describing: type) : key
        guard let factory = dependencies[key] as? () -> T else {
            return nil
        }
        return factory()
    }
    
    func resolve<T, Arg>(_ type: T.Type, argument: Arg, key: String = "") -> T? {
        let key = key.isEmpty ? String(describing: type) : key
        guard let factory = dependencies[key] as? (Arg) -> T else {
            return nil
        }
        return factory(argument)
    }
}
