//
//  ContentView.swift
//  TaskTracker
//
//  Created by Joshua Mandelson on 1/15/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var taskCount: Int = 0
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var newTaskTitle = ""
    
    var body: some View {
        VStack {
            Text("Task Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            HStack{
                TextField("New Task", text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)
                Button("Add"){
                    addTask()
                }
                .buttonStyle(.borderedProminent)
                .disabled(newTaskTitle.isEmpty)
            }
            List{
                ForEach(tasks) { task in
                    HStack{
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                        Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "seal")
                    }
                    .onTapGesture {
                        toggleTask(task)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
    private func addTask() {
        let newTask = Task(title: newTaskTitle)
        modelContext.insert(newTask)
        newTaskTitle = ""
    }
    
    private func toggleTask (_ task: Task) {
        task.isCompleted.toggle()
    }
    
    private func deleteTask(at offsets: IndexSet){
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}

#Preview {
    ContentView()
}

