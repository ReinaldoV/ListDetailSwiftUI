//
//  SearchEntity.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 27/6/24.
//

struct SearchEntity: Equatable {
    
    init(query: String, type: SearchTypeEntity) {
        self.query = query
        self.type = type
    }
    
    init(withSearch search: Search) {
        self.init(query: search.query,
                  type: .getFrom(search.type))
    }
    
    let query: String
    let type: SearchTypeEntity
}

enum SearchTypeEntity: String {
    case name
    case status
    
    static func getFrom(_ searchType: SearchType) -> SearchTypeEntity {
        switch searchType {
        case .name:
            return .name
        case .status:
            return .status
        }
    }
}
