// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


@testable import ListDetailSwiftUI















class FavoritesRepositoryTypeMock: FavoritesRepositoryType {

    //MARK: - saveFavorite

    var saveFavoriteFavoriteCallsCount = 0
    var saveFavoriteFavoriteCalled: Bool {
        return saveFavoriteFavoriteCallsCount > 0
    }
    var saveFavoriteFavoriteReceivedFavorite: CharacterEntity?
    var saveFavoriteFavoriteReceivedInvocations: [CharacterEntity] = []
    var saveFavoriteFavoriteClosure: ((CharacterEntity) -> Void)?

    func saveFavorite(favorite: CharacterEntity) {
        saveFavoriteFavoriteCallsCount += 1
        saveFavoriteFavoriteReceivedFavorite = favorite
        saveFavoriteFavoriteReceivedInvocations.append(favorite)
        saveFavoriteFavoriteClosure?(favorite)
    }

    //MARK: - loadFavorites

    var loadFavoritesCallsCount = 0
    var loadFavoritesCalled: Bool {
        return loadFavoritesCallsCount > 0
    }
    var loadFavoritesReturnValue: [CharacterEntity]!
    var loadFavoritesClosure: (() -> [CharacterEntity])?

    func loadFavorites() -> [CharacterEntity] {
        loadFavoritesCallsCount += 1
        return loadFavoritesClosure.map({ $0() }) ?? loadFavoritesReturnValue
    }

    //MARK: - deleteFavorite

    var deleteFavoriteFavoriteCallsCount = 0
    var deleteFavoriteFavoriteCalled: Bool {
        return deleteFavoriteFavoriteCallsCount > 0
    }
    var deleteFavoriteFavoriteReceivedFavorite: CharacterEntity?
    var deleteFavoriteFavoriteReceivedInvocations: [CharacterEntity] = []
    var deleteFavoriteFavoriteClosure: ((CharacterEntity) -> Void)?

    func deleteFavorite(favorite: CharacterEntity) {
        deleteFavoriteFavoriteCallsCount += 1
        deleteFavoriteFavoriteReceivedFavorite = favorite
        deleteFavoriteFavoriteReceivedInvocations.append(favorite)
        deleteFavoriteFavoriteClosure?(favorite)
    }

}
class FavoritesUserDefaultsDataSourceTypeMock: FavoritesUserDefaultsDataSourceType {

    //MARK: - saveFavorite

    var saveFavoriteFavoriteCallsCount = 0
    var saveFavoriteFavoriteCalled: Bool {
        return saveFavoriteFavoriteCallsCount > 0
    }
    var saveFavoriteFavoriteReceivedFavorite: CharacterDTO?
    var saveFavoriteFavoriteReceivedInvocations: [CharacterDTO] = []
    var saveFavoriteFavoriteClosure: ((CharacterDTO) -> Void)?

    func saveFavorite(favorite: CharacterDTO) {
        saveFavoriteFavoriteCallsCount += 1
        saveFavoriteFavoriteReceivedFavorite = favorite
        saveFavoriteFavoriteReceivedInvocations.append(favorite)
        saveFavoriteFavoriteClosure?(favorite)
    }

    //MARK: - loadFavorites

    var loadFavoritesCallsCount = 0
    var loadFavoritesCalled: Bool {
        return loadFavoritesCallsCount > 0
    }
    var loadFavoritesReturnValue: [CharacterDTO]!
    var loadFavoritesClosure: (() -> [CharacterDTO])?

    func loadFavorites() -> [CharacterDTO] {
        loadFavoritesCallsCount += 1
        return loadFavoritesClosure.map({ $0() }) ?? loadFavoritesReturnValue
    }

    //MARK: - deleteFavorite

    var deleteFavoriteFavoriteCallsCount = 0
    var deleteFavoriteFavoriteCalled: Bool {
        return deleteFavoriteFavoriteCallsCount > 0
    }
    var deleteFavoriteFavoriteReceivedFavorite: CharacterDTO?
    var deleteFavoriteFavoriteReceivedInvocations: [CharacterDTO] = []
    var deleteFavoriteFavoriteClosure: ((CharacterDTO) -> Void)?

    func deleteFavorite(favorite: CharacterDTO) {
        deleteFavoriteFavoriteCallsCount += 1
        deleteFavoriteFavoriteReceivedFavorite = favorite
        deleteFavoriteFavoriteReceivedInvocations.append(favorite)
        deleteFavoriteFavoriteClosure?(favorite)
    }

}
