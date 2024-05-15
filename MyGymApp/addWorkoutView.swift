//
//  addWorkoutView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 28.04.2024.
//

import SwiftUI
import SwiftData

struct addWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var duration: Int = 0
    @State private var exerciseCount : Int = 0
    @State private var difficulty : String = ""
    @State private var date: Date = .init()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Sample Workout", text:$title)
                }
                Section("Duration") {
                    TextField("60", value:$duration, format: .number)
                }
                Section("exerciseCount") {
                    TextField("10", value:$exerciseCount, format: .number)
                }
                Section("Difficulty") {
                    TextField("Beginner", text:$difficulty)
                }
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                
            }
            .navigationTitle("add Workout")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addWorkout()
                    }
                }
            }
        }
    }
    
    func addWorkout() {
        let workout = Workout(title: title, duration: duration, exerciseCount: exerciseCount, difficulty: difficulty, date: date, exercises: [])
        context.insert(workout)
        dismiss()
    }
}

#Preview {
    addWorkoutView()
}
