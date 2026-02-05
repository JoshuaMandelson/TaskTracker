//
//  ContentView.swift
//  TaskTracker
//
//  Created by Joshua Mandelson on 1/15/26.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @Query var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: TaskViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.gray, Color.white], startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea()
            VStack {
                Text("Task Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                HStack{
                    TextField("New Task", text: $viewModel.newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                    Button("Add"){
                        viewModel.addTask()
                    }
                    .buttonStyle(.borderedProminent)
                }
                List{
                    ForEach(tasks) { task in
                        HStack{
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                            Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "seal")
                        }
                        .onTapGesture {
                            viewModel.toggleTask(task)
                        }
                    }
                    .onDelete { offsets in
                        viewModel.deleteTask(at: offsets, tasks: tasks)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .padding()
        }
    }

}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    let context = container.mainContext
    
    // Create the view model with the preview's context
    let viewModel = TaskViewModel(modelContext: context)
    
    TaskView(viewModel: viewModel)
        .modelContainer(container)
}
