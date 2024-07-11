//
//  StationSearchUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 5/27/24.
//

import RxSwift

protocol StationSearchUseCase {
    func excute(by StationName: String) -> Single<StationList>
}
