//
//  DependencyInjector.swift
//  SubwayStation
//
//  Created by Kiseok on 6/24/24.
//

protocol DependencyAssemblable {
    func assemble(_ assemblyList: [Assembly])
}

protocol DependencyResolvable {
    func resolve<T>(_ type: T.Type) -> T
}

typealias Injectable = DependencyAssemblable & DependencyResolvable

final class DependencyInjector: Injectable {
    func assemble(_ assemblyList: [any Assembly]) {
        assemblyList.forEach {
            $0.assemble()
        }
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        DIContainer.shared.resolve(type)!
    }
}
