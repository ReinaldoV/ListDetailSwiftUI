//
//  InfoDTO.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

struct InfoDTO: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

extension InfoDTO {
    func toResponseInfoEntity() -> ResponseInfoEntity {
        return ResponseInfoEntity(count: self.count,
                                  pages: self.pages,
                                  next: self.next,
                                  prev: self.prev)
    }
}
