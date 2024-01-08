//
//  TaskDetailView.swift
//  ToDoList
//
//  Created by 이민호 on 1/8/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct TaskDetailView: View {
    let db = Firestore.firestore()
    var task: Task
    @State var title: String = ""
    
    var body: some View {
        VStack {
            TextField(task.title, text: self.$title)
            Button {
                updateTask()
            } label: {
                Text("save")
            }
        }
        .padding()
    }
}

extension TaskDetailView {
    func updateTask() {
        db.collection("tasks")
            .document(task.id ?? "")
            .updateData([
                "title": self.title
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Update is success!")
                }
            }
    }
}

#Preview {
    TaskDetailView(task: Task(id: "3333", title: "a vampire is on the table"))
}
