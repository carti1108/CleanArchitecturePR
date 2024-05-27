//
//  StationArrival.swift
//  SubwayStation
//
//  Created by Kiseok on 4/24/24.
//

struct StationArrival {
    var realtimeArrivalList: [RealTimeArrival] = .init()
}

struct RealTimeArrival {
    let line: String
    let remainTime: String
    let currentStation: String
}
