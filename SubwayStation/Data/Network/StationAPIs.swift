//
//  APIEndPoint.swift
//  SubwayStation
//
//  Created by Kiseok on 4/8/24.
//

struct StationAPIs {
    static func getStationInfo(by stationName: String) -> EndPoint<StationResponseDTO> {
        return EndPoint(baseURL: "http://openapi.seoul.go.kr:8088/",
                        path: "sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        )
    }
    
    static func getStationArrival(by stationName: String) -> EndPoint<StationArrivalDataResponseDTO> {
        return EndPoint(baseURL: "http://swopenapi.seoul.go.kr/",
                        path: "api/subway/sample/json/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
