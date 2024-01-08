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
    @State private var title: String = ""
    
    init() {
        self.db = Firestore.firestore()
    }
    
    var body: some View {
        VStack {
            TextField("Enter task", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding(.top, 30)
            Spacer()
            Button() {
                let task = Task(title: self.title)
                saveTask(task: task)
            } label: {
                Text("save")
            }
        }
        .padding()
    }
}

extension ContentView {
    func saveTask(task: Task) {
        do {
            _ = try db.collection("tasks").addDocument(from: task) { err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    print("Document has been saved!")
                }
            }
        } catch let err{
            print(err.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
