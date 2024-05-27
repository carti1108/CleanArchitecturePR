//
//  ProviderTests.swift
//  ProviderTests
//
//  Created by Kiseok on 4/16/24.
//

import XCTest
@testable import SubwayStation

final class ProviderTests: XCTestCase {
    var urlSession: URLSession!
    var provider: Provider!
    var endPoint = StationAPIs.getStationInfo(by: "강남")
    let mockResponse: Data =
    """
        
            {
                "SearchInfoBySubwayNameService": {
                "list_total_count": 2,
                "RESULT": {
                "CODE": "INFO-000",
                "MESSAGE": "정상 처리되었습니다"
            },
                "row": [
            {
                "STATION_CD": "0222",
                "STATION_NM": "강남",
                "LINE_NUM": "02호선",
                "FR_CODE": "222"
            },
            {
                "STATION_CD": "4307",
                "STATION_NM": "강남",
                "LINE_NUM": "신분당선",
                "FR_CODE": "D7"
            }
        ]
    }
}

""".data(using: .utf8)!
    

    override func setUpWithError() throws {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        
        provider = Provider(session: urlSession)
    }
    
    func test_request가_성공했을때() {
        let response = HTTPURLResponse(
            url: try! endPoint.url(),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let mockData = try? JSONDecoder().decode(StationResponseDTO.self, from: mockResponse)
        
        let expectation = XCTestExpectation(description: "response")
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockResponse)
        }
        
        provider.request(with: endPoint) { result in
            if case let .success(data) = result {
                let result = data.stations
                
                XCTAssertEqual(result, mockData?.stations)
                
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_request했을때_response가실패했을때_오류를던지는지() {
        let response = HTTPURLResponse(
            url: try! endPoint.url(),
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        let expectation = XCTestExpectation(description: "response")
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockResponse)
        }
        
        provider.request(with: endPoint) { result in
            if case let .failure(error) = result {
                guard let result = error as? NetworkError else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(result, NetworkError.invalidResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_request했을때_data가실패했을때_오류를던지는지() {
        let response = HTTPURLResponse(
            url: try! endPoint.url(),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let expectation = XCTestExpectation(description: "response")
        
        MockURLProtocol.requestHandler = { request in
            return (response, nil)
        }
        
        provider.request(with: endPoint) { result in
            if case let .failure(error) = result {
                guard let result = error as? NetworkError else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(result, NetworkError.decodedFailure)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
