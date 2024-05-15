//
//  addExerciseView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 10.05.2024.
//

import SwiftUI

struct addExerciseView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var workout : Workout
    @State private var name: String = ""
    @State private var sets: Int = 0
    @State private var reps: Int = 0
    @State private var weight : Int = 0
    var body: some View {
        NavigationStack {
            List {
                Section("name") {
                    TextField("Sample Exercise", text:$name)
                }
                Section("sets") {
                    TextField("3", value:$sets, format: .number)
                }
                Section("reps") {
                    TextField("10", value:$reps, format: .number)
                }
                Section("Weight") {
                    TextField("135", value: $weight, format: .number)
                }
                
            }
            .navigationTitle("add exercise")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addExercise()
                    }
                }
            }
        }
    }
    
    func addExercise() {
        let exercise = Exercise(name: name, sets: sets, reps: reps, weight: weight)
        workout.exercises.append(exercise)
        context.insert(exercise)
        context.insert(workout)
        dismiss()
    }
}


