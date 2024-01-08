//
//  ContentView.swift
//  ToDoList
//
//  Created by 이민호 on 1/8/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ContentView: View {
    
    private let db: Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

//#Preview {
//    ContentView(db: <#Firestore#>)
//}
