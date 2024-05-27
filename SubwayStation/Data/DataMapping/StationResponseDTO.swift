//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by Kiseok on 3/25/24.
//

struct StationResponseDTO: Decodable, Equatable {
    static func == (lhs: StationResponseDTO, rhs: StationResponseDTO) -> Bool {
        lhs.stations == rhs.stations
    }
    
    var stations: [StationDTO] { searchInfo.row }
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [StationDTO] = .init()
    }
}

struct StationDTO: Decodable, Equatable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}

extension StationResponseDTO {
    func toDomain() -> StationList {
        return StationList(stations: stations.map { $0.toDomain() })
    }
}

extension StationDTO {
    func toDomain() -> StationDetail {
        return StationDetail(stationName: stationName, lineNumber: lineNumber)
    }
}


