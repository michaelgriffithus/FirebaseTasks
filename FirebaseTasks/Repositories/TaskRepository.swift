//
//  TaskRepository.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/24/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    let db = Firestore.firestore();
    @Published var tasks = [Task]()

    
    init() {
        loadData()
    }
    
    func updateTask(task: Task){
        if let taskID = task.id {
            print("Trying to update task with id: \(taskID)")
            do {
                try db.collection("task").document(taskID).setData(from: task)
            } catch {
                fatalError("Unable to update task \(error.localizedDescription)")
            }
            
        }
    }
    
    func addTask(task: Task){
        do {
            var taskToAdd = task;
            taskToAdd.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("task").addDocument(from: taskToAdd) // swallow compiler warning, don't care about result
        } catch  {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        print("User Id \(userId ?? "Not Logged in")")
        
        db.collection("task")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener{ (querySnapshot, error) in
                if let querySnapshot = querySnapshot { // not nil
                    self.tasks = querySnapshot.documents.compactMap{ document in // get all the documents
                        do {
                            let x = try document.data(as: Task.self)
                            return x
                        } catch  {
                            print("Error in loading the data \(error)")
                        }
                        return nil
                    }
                }
        }
    }
}
