//
//  editExerciseView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 11.05.2024.
//

import SwiftUI

struct editExerciseView: View {
    @Bindable var ex : Exercise
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("name") {
                    TextField("Sample Exercise", text:$ex.name)
                }
                Section("sets") {
                    TextField("3", value:$ex.sets, format: .number)
                }
                Section("reps") {
                    TextField("10", value:$ex.reps, format: .number)
                }
                Section("Weight") {
                    TextField("135", value: $ex.weight, format: .number)
                }
                
            }
            .navigationTitle("edit exercise")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save Changes") {
                        editExercise()
                    }
                }
            }
        }
    }
    
    func editExercise() {
        context.insert(ex)
        dismiss()
    }
}

