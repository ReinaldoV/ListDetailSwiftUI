//
//  APIService.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Foundation
import Combine

protocol APIServiceType {
    var session: URLSession {get}
    var baseURL: String {get}
    var bgQueue: DispatchQueue {get}
    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType
    func call<Request>(from endpoint: Request) async throws -> Request.ModelType  where Request : APIRequestType
}

final class APIService: APIServiceType {

    internal let baseURL: String
    internal let session: URLSession = URLSession.shared
    internal let bgQueue: DispatchQueue = DispatchQueue.main

    init(baseURL: String) {
        self.baseURL = baseURL
    }
 
    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request : APIRequestType {
        do {
            let request = try endpoint.buildRequest(baseURL: baseURL)
            return session.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIServiceError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIServiceError.httpError(code)
                    }
                    return $0.data  // Pass data to downstream publishers
                }
                .decode(type: Request.ModelType.self, decoder: JSONDecoder())
                .mapError {_ in APIServiceError.parseError}
                .receive(on: self.bgQueue)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Request.ModelType, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func call<Request>(from endpoint: Request) async throws -> Request.ModelType  where Request : APIRequestType {
        let request = try endpoint.buildRequest(baseURL: baseURL)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIServiceError.unexpectedResponse }
        guard httpResponse.statusCode == 200 else { throw APIServiceError.httpError(httpResponse.statusCode) }
        
        let parsedData = try JSONDecoder().decode(Request.ModelType.self, from: data)
        
        return parsedData
    }
}
