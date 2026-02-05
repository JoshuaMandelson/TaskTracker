//
//  Task.swift
//  TaskTracker
//
//  Created by Joshua Mandelson on 1/16/26.
//

import Foundation
import SwiftData

@Model
class Task {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
