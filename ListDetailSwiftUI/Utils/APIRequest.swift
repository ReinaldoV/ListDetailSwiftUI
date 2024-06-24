//
//  APIRequest.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Foundation

protocol APIRequestType {
    associatedtype ModelType: Decodable
    
    var path: String {get}
    var method: String {get}
    var headers: [String: String]? {get}
    var queryItems: [URLQueryItem]? {get}
    func body() throws -> Data?
}

extension APIRequestType {
    func buildRequest(baseURL: String) throws -> URLRequest {
        
        guard let url = URL(string: baseURL + path) else {
            throw APIServiceError.invalidURL
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
