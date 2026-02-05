//
//  TaskTrackerApp.swift
//  TaskTracker
//
//  Created by Joshua Mandelson on 1/15/26.
//

import SwiftUI
import SwiftData

@main
struct TaskTrackerApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Task.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: TaskViewModel(modelContext: modelContainer.mainContext))
        }
        .modelContainer(modelContainer)
    }
}
