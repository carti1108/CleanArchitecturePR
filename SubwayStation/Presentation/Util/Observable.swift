//
//  Observable.swift
//  SubwayStation
//
//  Created by Kiseok on 4/10/24.
//

final class Observable<T> {
    var listener: ((T) -> Void)?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: ((T) -> Void)?) {
        self.listener = listener
    }
}
