//
//  TaskCellViewModel.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/23/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel : ObservableObject, Identifiable {
    @Published var taskRepository = TaskRepository()
    @Published var task: Task
    var id = ""
    @Published var completionStateIconName = ""
    private var cancelables = Set<AnyCancellable>()
    
    static func newTask() -> TaskCellViewModel {
      TaskCellViewModel(task: Task(title: "", completed: false))
    }
    
    init(task: Task){
        self.task = task
        
        $task
            .map{ task in
                task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancelables)
        
        // pipeline
        $task
            .compactMap{ task in
                task.id
        }    .assign(to: \.id, on: self)
            .store(in: &cancelables)
        
        // pipeline
        $task
        .dropFirst() // prevent endless loop by preventing framework from sending update
            .debounce(for: 0.8, scheduler: RunLoop.main) // prevent sending to firestore while typing
            .sink{ task in
            self.taskRepository.updateTask(task: task)
        }.store(in: &cancelables)
        
    }
}

//
