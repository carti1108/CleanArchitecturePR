//
//  StationRepository.swift
//  SubwayStation
//
//  Created by Kiseok on 4/25/24.
//

protocol StationSearchRepository {
    func fetchStationInfo(by stationName: String, completion: @escaping (Result<StationList, Error>) -> Void)
}
