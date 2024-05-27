//
//  StationArrivalDataResponseModel.swift
//  SubwayStation
//
//  Created by Kiseok on 3/25/24.
//

struct StationArrivalDataResponseDTO: Decodable {
    var realtimeArrivalList: [RealTimeArrival] = .init()
    
    struct RealTimeArrival: Decodable {
        let line: String
        let remainTime: String
        let currentStation: String
        
        enum CodingKeys: String, CodingKey {
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}

extension StationArrivalDataResponseDTO.RealTimeArrival {
    func toDomain() -> RealTimeArrival {
        return RealTimeArrival(
            line: line,
            remainTime: remainTime,
            currentStation: currentStation
        )
    }
}

extension StationArrivalDataResponseDTO {
    func toDomain() -> StationArrival {
        return StationArrival(realtimeArrivalList: realtimeArrivalList.map { $0.toDomain() })
    }
}
