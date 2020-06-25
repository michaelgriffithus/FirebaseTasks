//
//  TaskListViewModel.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/23/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks.map{ tasks in
            tasks.map{ task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancelables)
        
        self.taskCellViewModels = testData.map{ task in
            TaskCellViewModel(task: task)
        }
    }
    
    func addTask(task: Task){
        taskRepository.addTask(task: task);
    }
}
