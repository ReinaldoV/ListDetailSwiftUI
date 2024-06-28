//
//  EpisodesRepositoryTests.swift
//  ListDetailSwiftUITests
//
//  Created by Villanueva, Reinaldo on 28/6/24.
//

@testable import ListDetailSwiftUI
import XCTest
import Combine

class EpisodesRepositoryTests: XCTestCase {
    var sut: EpisodesRepository!
    var userDefaultsDataSourceMock: EpisodesUserDefaultsDataSourceTypeMock!
    var cacheDataSourceMock: EpisodesCacheDataSourceTypeMock!
    var apiServiceMock: APIServiceEpisodeTypeMock!
    
    override func setUp() {
        super.setUp()
        
        userDefaultsDataSourceMock = EpisodesUserDefaultsDataSourceTypeMock()
        cacheDataSourceMock = EpisodesCacheDataSourceTypeMock()
        apiServiceMock = APIServiceEpisodeTypeMock()
        
        sut = .init(userDefaultsDataSource: userDefaultsDataSourceMock,
                    cacheDataSource: cacheDataSourceMock,
                    service: apiServiceMock)
    }
    
    func testThatOnlyCacheIsCalled_When_RetrievenEpisodes_And_CacheHasEpisodes() async throws {
        cacheDataSourceMock.loadEpisodesReturnValue = [episodeDTO()]
        
        _ = try await sut.callForAllEpisodes()
        
        XCTAssertEqual(1, cacheDataSourceMock.loadEpisodesCallsCount)
        XCTAssertEqual(0, apiServiceMock.callFromCallsCount)
        XCTAssertEqual(0, userDefaultsDataSourceMock.loadEpisodesCallsCount)
    }
    
    func testThatApiIsCalled_When_RetrievenEpisodes_And_CacheHasNoEpisodes() async throws {
        cacheDataSourceMock.loadEpisodesReturnValue = nil
        apiServiceMock.callAsyncFromReturnValue = .init(info: .init(count: 0, pages: 5),
                                                        results: [episodeDTO()])
        
        _ = try await sut.callForAllEpisodes()
        
        XCTAssertEqual(1, cacheDataSourceMock.loadEpisodesCallsCount)
        XCTAssertEqual(1, apiServiceMock.callFromCallsCount)
        XCTAssertEqual(0, userDefaultsDataSourceMock.loadEpisodesCallsCount)
    }
    
    func testThatLocalDataIsCalled_When_RetrievenEpisodes_And_CacheHasNoEpisodes_AndApiFails() async throws {
        cacheDataSourceMock.loadEpisodesReturnValue = nil
        apiServiceMock.callFromThrowableError = ErrorMock()
        userDefaultsDataSourceMock.loadEpisodesReturnValue = [episodeDTO()]
        
        _ = try await sut.callForAllEpisodes()
        
        XCTAssertEqual(1, cacheDataSourceMock.loadEpisodesCallsCount)
        XCTAssertEqual(1, apiServiceMock.callFromCallsCount)
        XCTAssertEqual(1, userDefaultsDataSourceMock.loadEpisodesCallsCount)
    }
    
    private func episodeDTO() -> EpisodeDTO {
        EpisodeDTO(id: 0,
                   name: "",
                   airDate: "",
                   episode: "")
    }
}
