//
//  StationSearchUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 5/27/24.
//

protocol StationSearchUseCase {
    func excute(by stationName: String, completion: @escaping (Result<StationList, Error>) -> Void)
}
