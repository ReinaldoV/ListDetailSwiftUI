//
//  Search.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 27/6/24.
//

struct Search {
    let query: String
    let type: SearchType
}

enum SearchType: String, Identifiable, CaseIterable {
    case name = "Name"
    case status = "Status"
    
    var id: Self { self }
}
