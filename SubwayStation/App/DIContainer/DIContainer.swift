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
    
    func register<T>(_ dependency: T, for type: T.Type, key: String = "") {
        let key = key.isEmpty ? String(describing: type) : key
        self.dependencies[key] = dependency
    }
    
    func resolve<T>(_ type: T.Type, key: String = "") -> T? {
        let key = key.isEmpty ? String(describing: type) : key
        return dependencies[key] as? T
    }
}
