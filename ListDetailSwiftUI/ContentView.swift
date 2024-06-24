//
//  ContentView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var repo = CharacterRepository()
    @State var cancellables = [AnyCancellable]()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            let cancellable = repo.callForCharacters().sink { error in
                print(error)
            } receiveValue: { (info, characters) in
                print(info)
                print(characters)
            }
            cancellables.append(cancellable)
        })
    }
}

#Preview {
    ContentView()
}
