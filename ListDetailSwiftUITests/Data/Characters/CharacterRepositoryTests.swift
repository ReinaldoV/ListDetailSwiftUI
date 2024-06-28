//
//  CharacterRepositoryTests.swift
//  ListDetailSwiftUITests
//
//  Created by Villanueva, Reinaldo on 28/6/24.
//

@testable import ListDetailSwiftUI
import XCTest
import Combine

class CharacterRepositoryTests: XCTestCase {
    var sut: CharacterRepository!
    private var apiServiceMock: APIServiceCharacterTypeMock!
    
    override func setUp() {
        super.setUp()
        
        apiServiceMock = APIServiceCharacterTypeMock()
        
        sut = CharacterRepository(service: apiServiceMock)
    }
    
    func testThatCallsForApi_When_CallsForCharacters() {
        let mockValue = CharacterListDTO(info: .init(count: 0, pages: 5),
                                         results: [characterDTO()])
        apiServiceMock.callFromReturnValue = CurrentValueSubject<CharacterListDTO, Error>.init(mockValue).eraseToAnyPublisher()
        
        let result = sut.callForCharacters(pageNum: 0, withSearch: .init(query: "", type: .name))
        
        XCTAssertEqual(1, apiServiceMock.callFromCallsCount)
        
        _ = result.sink { _ in
            XCTFail("Should not send an error")
        } receiveValue: { (info, characters) in
            XCTAssertEqual(5, info.pages)
            XCTAssertEqual(0, characters.first?.id)
            XCTAssertEqual("", characters.first?.name)
        }

    }
    
    private func characterDTO() -> CharacterDTO {
        CharacterDTO(id: 0,
                     name: "",
                     status: .alive,
                     species: "",
                     origin: .init(name: ""),
                     location: .init(name: ""),
                     episode: [],
                     image: "")
    }
}
