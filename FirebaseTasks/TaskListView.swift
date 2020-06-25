//
//  ContentView.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/23/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @State var presentAddNewItem = false
    var body: some View {
        VStack {
            NavigationView{
                
                VStack(alignment: .leading) {
                    List{
                        ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                        }
                        if presentAddNewItem {
                            TaskCell(taskCellVM: TaskCellViewModel.newTask()){ task in // trailing cloure
                                self.taskListVM.addTask(task: task);
                                self.presentAddNewItem.toggle()
                            }
                        }
                    }
                    Button(action: {self.presentAddNewItem.toggle()}) {
                        HStack {
                            Image(systemName: "plus.circle.fill").padding(.bottom)
                            Text("Add New Task").padding(.bottom)
                        }.padding(.leading)
                    }
                }
                .navigationBarTitle("Tasks")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Task) -> (Void) = { _ in } // tricks the compliler by providing a default dummy implementation
    var body: some View{
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle").resizable().frame(width:20, height: 20).onTapGesture {
                self.taskCellVM.task.completed.toggle();
            }
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}

