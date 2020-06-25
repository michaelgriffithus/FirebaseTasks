//
//  Task.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/23/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp? // use the server timestamp (@Servertimestamp is a property wrapper)
    var userId: String?
}

#if DEBUG
let testData = [
    Task(title: "Implement UI", completed:  true),
    Task(title: "Connect to Firebase", completed: false),
    Task(title: "???", completed: false),
    Task(title: "Profit", completed: false)
]
#endif
