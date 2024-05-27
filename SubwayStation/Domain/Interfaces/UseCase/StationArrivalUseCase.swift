//
//  StationArrivalUseCase.swift
//  SubwayStation
//
//  Created by Kiseok on 5/27/24.
//

protocol StationArrivalUseCase {
    func excute(by stationName: String, completion: @escaping (Result<StationArrival, Error>) -> Void)
}
