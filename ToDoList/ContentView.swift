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
    @State private var tasks: [Task] = []
    
    init() {
        self.db = Firestore.firestore()
    }
    
    var body: some View {
        VStack {
            TextField("Enter task", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding(.top, 30)
            Button() {
                let task = Task(title: self.title)
                saveTask(task: task)
            } label: {
                Text("save")
            }
            List{
                ForEach(tasks, id: \.title) { task in
                    Text(task.title)
                }
                .onDelete(perform: deleteTask)
            }
            
        }
        .padding()
        .onAppear() {
            fetchAllTasks()
        }
    }
}

extension ContentView {
    private func saveTask(task: Task) {
        do {
            _ = try db.collection("tasks").addDocument(from: task) { err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    print("Document has been saved!")
                    fetchAllTasks()
                }
            }
        } catch let err{
            print(err.localizedDescription)
        }
    }
    
    private func fetchAllTasks() {
        db.collection("tasks")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapshot = snapshot {
                        tasks = snapshot.documents.compactMap { doc in
                            var task = try? doc.data(as: Task.self)
                            task?.id = doc.documentID
                                                        
                            return task
                        }
                    }
                }
            }
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let task = tasks[index]
            db.collection("tasks")
                .document(task.id ?? "")
                .delete { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        fetchAllTasks()
                    }
                }
                
        }
    }
}

#Preview {
    ContentView()
}
