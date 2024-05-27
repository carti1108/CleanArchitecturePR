//
//  StationDetailRepository.swift
//  SubwayStation
//
//  Created by Kiseok on 4/29/24.
//

protocol StationArrivalRepository {
    func fetchStationArrival(by stationName: String, completion: @escaping (Result<StationArrival, Error>) -> Void) 
}
