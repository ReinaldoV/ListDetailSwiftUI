// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


@testable import ListDetailSwiftUI















class APIRequestTypeMock: APIRequestType {
    var path: String {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }
    var underlyingPath: String!
    var method: String {
        get { return underlyingMethod }
        set(value) { underlyingMethod = value }
    }
    var underlyingMethod: String!
    var headers: [String: String]?
    var queryItems: [URLQueryItem]?

    //MARK: - body

    var bodyThrowableError: Error?
    var bodyCallsCount = 0
    var bodyCalled: Bool {
        return bodyCallsCount > 0
    }
    var bodyReturnValue: Data?
    var bodyClosure: (() throws -> Data?)?

    func body() throws -> Data? {
        bodyCallsCount += 1
        if let error = bodyThrowableError {
            throw error
        }
        return try bodyClosure.map({ try $0() }) ?? bodyReturnValue
    }

}
class APIServiceTypeMock: APIServiceType {
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

    //MARK: - call<Request>

    var callFromCallsCount = 0
    var callFromCalled: Bool {
        return callFromCallsCount > 0
    }
    var callFromReceivedEndpoint: Request?
    var callFromReceivedInvocations: [Request] = []
    var callFromReturnValue: AnyPublisher<Request.ModelType, Error> where Request: APIRequestType!
    var callFromClosure: ((Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType)?

    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType {
        callFromCallsCount += 1
        callFromReceivedEndpoint = endpoint
        callFromReceivedInvocations.append(endpoint)
        return callFromClosure.map({ $0(endpoint) }) ?? callFromReturnValue
    }

    //MARK: - call<Request>

    var callFromThrowableError: Error?
    var callFromCallsCount = 0
    var callFromCalled: Bool {
        return callFromCallsCount > 0
    }
    var callFromReceivedEndpoint: Request?
    var callFromReceivedInvocations: [Request] = []
    var callFromReturnValue: Request.ModelType where Request : APIRequestType!
    var callFromClosure: ((Request) throws -> Request.ModelType where Request : APIRequestType)?

    func call<Request>(from endpoint: Request) throws -> Request.ModelType where Request : APIRequestType {
        callFromCallsCount += 1
        callFromReceivedEndpoint = endpoint
        callFromReceivedInvocations.append(endpoint)
        if let error = callFromThrowableError {
            throw error
        }
        return try callFromClosure.map({ try $0(endpoint) }) ?? callFromReturnValue
    }

}
class CharacterRepositoryTypeMock: CharacterRepositoryType {

    //MARK: - callForCharacters

    var callForCharactersPageNumWithSearchCallsCount = 0
    var callForCharactersPageNumWithSearchCalled: Bool {
        return callForCharactersPageNumWithSearchCallsCount > 0
    }
    var callForCharactersPageNumWithSearchReceivedArguments: (pageNum: Int, withSearch: SearchEntity)?
    var callForCharactersPageNumWithSearchReceivedInvocations: [(pageNum: Int, withSearch: SearchEntity)] = []
    var callForCharactersPageNumWithSearchReturnValue: AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error>!
    var callForCharactersPageNumWithSearchClosure: ((Int, SearchEntity) -> AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error>)?

    func callForCharacters(pageNum: Int, withSearch: SearchEntity) -> AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error> {
        callForCharactersPageNumWithSearchCallsCount += 1
        callForCharactersPageNumWithSearchReceivedArguments = (pageNum: pageNum, withSearch: withSearch)
        callForCharactersPageNumWithSearchReceivedInvocations.append((pageNum: pageNum, withSearch: withSearch))
        return callForCharactersPageNumWithSearchClosure.map({ $0(pageNum, withSearch) }) ?? callForCharactersPageNumWithSearchReturnValue
    }

}
class CharactersUseCaseTypeMock: CharactersUseCaseType {

    //MARK: - callForCharacters

    var callForCharactersWithSearchCallsCount = 0
    var callForCharactersWithSearchCalled: Bool {
        return callForCharactersWithSearchCallsCount > 0
    }
    var callForCharactersWithSearchReceivedSearch: Search?
    var callForCharactersWithSearchReceivedInvocations: [Search] = []
    var callForCharactersWithSearchReturnValue: AnyPublisher<[Character], Error>!
    var callForCharactersWithSearchClosure: ((Search) -> AnyPublisher<[Character], Error>)?

    func callForCharacters(withSearch search: Search) -> AnyPublisher<[Character], Error> {
        callForCharactersWithSearchCallsCount += 1
        callForCharactersWithSearchReceivedSearch = search
        callForCharactersWithSearchReceivedInvocations.append(search)
        return callForCharactersWithSearchClosure.map({ $0(search) }) ?? callForCharactersWithSearchReturnValue
    }

}
class EpisodesCacheDataSourceTypeMock: EpisodesCacheDataSourceType {

    //MARK: - setCache

    var setCacheEpisodesCallsCount = 0
    var setCacheEpisodesCalled: Bool {
        return setCacheEpisodesCallsCount > 0
    }
    var setCacheEpisodesReceivedEpisodes: [EpisodeDTO]?
    var setCacheEpisodesReceivedInvocations: [[EpisodeDTO]] = []
    var setCacheEpisodesClosure: (([EpisodeDTO]) -> Void)?

    func setCache(episodes: [EpisodeDTO]) {
        setCacheEpisodesCallsCount += 1
        setCacheEpisodesReceivedEpisodes = episodes
        setCacheEpisodesReceivedInvocations.append(episodes)
        setCacheEpisodesClosure?(episodes)
    }

    //MARK: - loadEpisodes

    var loadEpisodesCallsCount = 0
    var loadEpisodesCalled: Bool {
        return loadEpisodesCallsCount > 0
    }
    var loadEpisodesReturnValue: [EpisodeDTO]?
    var loadEpisodesClosure: (() -> [EpisodeDTO]?)?

    func loadEpisodes() -> [EpisodeDTO]? {
        loadEpisodesCallsCount += 1
        return loadEpisodesClosure.map({ $0() }) ?? loadEpisodesReturnValue
    }

}
class EpisodesRepositoryTypeMock: EpisodesRepositoryType {

    //MARK: - getEpisode

    var getEpisodeByIdThrowableError: Error?
    var getEpisodeByIdCallsCount = 0
    var getEpisodeByIdCalled: Bool {
        return getEpisodeByIdCallsCount > 0
    }
    var getEpisodeByIdReceivedId: Int?
    var getEpisodeByIdReceivedInvocations: [Int] = []
    var getEpisodeByIdReturnValue: EpisodeEntity?
    var getEpisodeByIdClosure: ((Int) throws -> EpisodeEntity?)?

    func getEpisode(byId id: Int) throws -> EpisodeEntity? {
        getEpisodeByIdCallsCount += 1
        getEpisodeByIdReceivedId = id
        getEpisodeByIdReceivedInvocations.append(id)
        if let error = getEpisodeByIdThrowableError {
            throw error
        }
        return try getEpisodeByIdClosure.map({ try $0(id) }) ?? getEpisodeByIdReturnValue
    }

    //MARK: - callForAllEpisodes

    var callForAllEpisodesThrowableError: Error?
    var callForAllEpisodesCallsCount = 0
    var callForAllEpisodesCalled: Bool {
        return callForAllEpisodesCallsCount > 0
    }
    var callForAllEpisodesReturnValue: [EpisodeEntity]!
    var callForAllEpisodesClosure: (() throws -> [EpisodeEntity])?

    func callForAllEpisodes() throws -> [EpisodeEntity] {
        callForAllEpisodesCallsCount += 1
        if let error = callForAllEpisodesThrowableError {
            throw error
        }
        return try callForAllEpisodesClosure.map({ try $0() }) ?? callForAllEpisodesReturnValue
    }

}
class EpisodesUseCaseTypeMock: EpisodesUseCaseType {

    //MARK: - getEpisode

    var getEpisodeByIdCallsCount = 0
    var getEpisodeByIdCalled: Bool {
        return getEpisodeByIdCallsCount > 0
    }
    var getEpisodeByIdReceivedById: Int?
    var getEpisodeByIdReceivedInvocations: [Int] = []
    var getEpisodeByIdReturnValue: Episode?
    var getEpisodeByIdClosure: ((Int) -> Episode?)?

    func getEpisode(byId: Int) -> Episode? {
        getEpisodeByIdCallsCount += 1
        getEpisodeByIdReceivedById = byId
        getEpisodeByIdReceivedInvocations.append(byId)
        return getEpisodeByIdClosure.map({ $0(byId) }) ?? getEpisodeByIdReturnValue
    }

}
class EpisodesUserDefaultsDataSourceTypeMock: EpisodesUserDefaultsDataSourceType {

    //MARK: - saveEpisodes

    var saveEpisodesEpisodesCallsCount = 0
    var saveEpisodesEpisodesCalled: Bool {
        return saveEpisodesEpisodesCallsCount > 0
    }
    var saveEpisodesEpisodesReceivedEpisodes: [EpisodeDTO]?
    var saveEpisodesEpisodesReceivedInvocations: [[EpisodeDTO]] = []
    var saveEpisodesEpisodesClosure: (([EpisodeDTO]) -> Void)?

    func saveEpisodes(episodes: [EpisodeDTO]) {
        saveEpisodesEpisodesCallsCount += 1
        saveEpisodesEpisodesReceivedEpisodes = episodes
        saveEpisodesEpisodesReceivedInvocations.append(episodes)
        saveEpisodesEpisodesClosure?(episodes)
    }

    //MARK: - loadEpisodes

    var loadEpisodesCallsCount = 0
    var loadEpisodesCalled: Bool {
        return loadEpisodesCallsCount > 0
    }
    var loadEpisodesReturnValue: [EpisodeDTO]!
    var loadEpisodesClosure: (() -> [EpisodeDTO])?

    func loadEpisodes() -> [EpisodeDTO] {
        loadEpisodesCallsCount += 1
        return loadEpisodesClosure.map({ $0() }) ?? loadEpisodesReturnValue
    }

    //MARK: - deleteEpisodes

    var deleteEpisodesCallsCount = 0
    var deleteEpisodesCalled: Bool {
        return deleteEpisodesCallsCount > 0
    }
    var deleteEpisodesClosure: (() -> Void)?

    func deleteEpisodes() {
        deleteEpisodesCallsCount += 1
        deleteEpisodesClosure?()
    }

}
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
class FavoritesUseCaseTypeMock: FavoritesUseCaseType {

    //MARK: - isFavorite

    var isFavoriteFavoriteCallsCount = 0
    var isFavoriteFavoriteCalled: Bool {
        return isFavoriteFavoriteCallsCount > 0
    }
    var isFavoriteFavoriteReceivedFavorite: Character?
    var isFavoriteFavoriteReceivedInvocations: [Character] = []
    var isFavoriteFavoriteReturnValue: Bool!
    var isFavoriteFavoriteClosure: ((Character) -> Bool)?

    func isFavorite(favorite: Character) -> Bool {
        isFavoriteFavoriteCallsCount += 1
        isFavoriteFavoriteReceivedFavorite = favorite
        isFavoriteFavoriteReceivedInvocations.append(favorite)
        return isFavoriteFavoriteClosure.map({ $0(favorite) }) ?? isFavoriteFavoriteReturnValue
    }

    //MARK: - saveFavorite

    var saveFavoriteFavoriteCallsCount = 0
    var saveFavoriteFavoriteCalled: Bool {
        return saveFavoriteFavoriteCallsCount > 0
    }
    var saveFavoriteFavoriteReceivedFavorite: Character?
    var saveFavoriteFavoriteReceivedInvocations: [Character] = []
    var saveFavoriteFavoriteClosure: ((Character) -> Void)?

    func saveFavorite(favorite: Character) {
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
    var loadFavoritesReturnValue: [Character]!
    var loadFavoritesClosure: (() -> [Character])?

    func loadFavorites() -> [Character] {
        loadFavoritesCallsCount += 1
        return loadFavoritesClosure.map({ $0() }) ?? loadFavoritesReturnValue
    }

    //MARK: - deleteFavorite

    var deleteFavoriteFavoriteCallsCount = 0
    var deleteFavoriteFavoriteCalled: Bool {
        return deleteFavoriteFavoriteCallsCount > 0
    }
    var deleteFavoriteFavoriteReceivedFavorite: Character?
    var deleteFavoriteFavoriteReceivedInvocations: [Character] = []
    var deleteFavoriteFavoriteClosure: ((Character) -> Void)?

    func deleteFavorite(favorite: Character) {
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
