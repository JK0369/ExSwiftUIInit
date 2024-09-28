//
//  ContentView.swift
//  ExSwiftUI
//
//  Created by 김종권 on 2024/09/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SuperView()
        }
        .padding()
    }
}

class Person: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
        print("init > Person Model")
    }
}

struct SuperView: View {
    @StateObject var person = Person(name: "jake")
    
    init() {
        print("init> SuperView")
    }
    
    var body: some View {
        VStack {
            Subview(person: person)
        }
        .environmentObject(person)
    }
}

struct Subview: View {
    @StateObject var personByState = Person(name: "jake")
    @ObservedObject var personByObservedObject: Person = Person(name: "jake")
    @EnvironmentObject var personByEnvironmentObject: Person
    @State var counter = 0
        
    init(person: Person) {
//        _personByObservedObject = .init(wrappedValue: person)
        print("init > Subview")
    }
    
    var body: some View {
        VStack {
            Text(personByState.name + personByObservedObject.name)
            
            Text("\(counter)")
                .onAppear {
                    Task {
                        for _ in 1...100 {
//                            personByState.name = "\(counter)"
                            personByObservedObject.name = "\(counter)"
//                            personByEnvironmentObject.name = "\(counter)"
                            
                            counter += 1
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                        }
                    }
                }
                .onAppear()
        }
    }
}


#Preview {
    ContentView()
}
