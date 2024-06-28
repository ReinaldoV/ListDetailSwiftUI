//
//  APIServiceEpisodeTypeMock.swift
//  ListDetailSwiftUITests
//
//  Created by Villanueva, Reinaldo on 28/6/24.
//

@testable import ListDetailSwiftUI
import Combine
import Foundation

class APIServiceEpisodeTypeMock: APIServiceType {
    typealias Request = EpisodesListRequest
    typealias ModelType = EpisodesListDTO
    var session: URLSession {
        get { return underlyingSession }
        set(value) { underlyingSession = value }
    }
    var underlyingSession: URLSession!
    var baseURL: String {
        get { return underlyingBaseURL }
        set(value) { underlyingBaseURL = value }
    }
    var underlyingBaseURL: String!
    var bgQueue: DispatchQueue {
        get { return underlyingBgQueue }
        set(value) { underlyingBgQueue = value }
    }
    var underlyingBgQueue: DispatchQueue!
    
    init() {}

    //MARK: - call<Request>

    var callFromCallsCount = 0
    var callFromCalled: Bool {
        return callFromCallsCount > 0
    }
    var callFromReceivedEndpoint: Request?
    var callFromReceivedInvocations: [Request] = []
    var callFromReturnValue: AnyPublisher<ModelType, Error>!

    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType {
        callFromCallsCount += 1
        callFromReceivedEndpoint = endpoint as? EpisodesListRequest
        callFromReceivedInvocations.append(endpoint as! EpisodesListRequest)
        return callFromReturnValue as! AnyPublisher<Request.ModelType, Error>
    }

    //MARK: - call<Request>

    var callFromThrowableError: Error?
    var callAsyncFromReturnValue: ModelType!

    func call<Request>(from endpoint: Request) throws -> Request.ModelType where Request : APIRequestType {
        callFromCallsCount += 1
        callFromReceivedEndpoint = endpoint as? EpisodesListRequest
        callFromReceivedInvocations.append(endpoint as! EpisodesListRequest)
        if let error = callFromThrowableError {
            throw error
        }
        return callAsyncFromReturnValue as! Request.ModelType
    }

}
