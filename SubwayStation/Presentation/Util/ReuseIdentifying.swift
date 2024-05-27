//
//  ReuseIdentifying.swift
//  SubwayStation
//
//  Created by Kiseok on 4/12/24.
//

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
