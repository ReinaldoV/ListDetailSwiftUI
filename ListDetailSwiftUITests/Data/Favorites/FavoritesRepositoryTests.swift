//
//  FavoritesRepositoryTests.swift
//  ListDetailSwiftUITests
//
//  Created by Villanueva, Reinaldo on 28/6/24.
//

@testable import ListDetailSwiftUI
import XCTest

class FavoritesRepositoryTests: XCTestCase {
    var sut: FavoritesRepository!
    private var dataSourceMock: FavoritesUserDefaultsDataSourceTypeMock!
    
    override func setUp() {
        super.setUp()
        
        dataSourceMock = FavoritesUserDefaultsDataSourceTypeMock()
        
        sut = FavoritesRepository(dataSource: dataSourceMock)
    }
    
    func testThatSaveFavoriteInDataSourceIsCalled_When_SaveFavoriteIsCalled() {
        sut.saveFavorite(favorite: characterEntity())
        
        XCTAssertEqual(1, dataSourceMock.saveFavoriteFavoriteCallsCount)
        XCTAssertEqual(0, dataSourceMock.saveFavoriteFavoriteReceivedFavorite?.id)
        XCTAssertEqual("", dataSourceMock.saveFavoriteFavoriteReceivedFavorite?.name)
    }
    
    func testThatLoadFavoritesInDataSourceIsCalled_When_LoadFavoritesIsCalled() {
        dataSourceMock.loadFavoritesReturnValue = []
        
        let result = sut.loadFavorites()
        
        XCTAssertEqual(1, dataSourceMock.loadFavoritesCallsCount)
        XCTAssertEqual([], result)
    }
    
    func testThatDeleteFavoriteInDataSourceIsCalled_When_DeleteFavoriteIsCalled() {
        sut.deleteFavorite(favorite: characterEntity())
        
        XCTAssertEqual(1, dataSourceMock.deleteFavoriteFavoriteCallsCount)
        XCTAssertEqual(0, dataSourceMock.deleteFavoriteFavoriteReceivedFavorite?.id)
        XCTAssertEqual("", dataSourceMock.deleteFavoriteFavoriteReceivedFavorite?.name)
    }
    
    private func characterEntity() -> CharacterEntity {
        CharacterEntity(id: 0,
                        name: "",
                        status: .alive,
                        species: "",
                        origin: "",
                        location: "",
                        episodes: [],
                        image: "")
    }
}
