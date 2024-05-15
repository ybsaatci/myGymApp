//
//  exerciseView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 10.05.2024.
//

import SwiftUI
import SwiftData
struct exerciseView: View {
    @Bindable var workout : Workout
    @Query private var allExercises :[Exercise]
    @Environment(\.modelContext) private var context
    @State private var addExercise : Bool = false
    @State private var workouts : [Workout] = []
    var body: some View {
        NavigationStack {
            List {
                ForEach(workout.exercises ?? [], id: \.self) { exercise in
                    exView(ex: exercise)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                context.delete(exercise)
                                withAnimation {
                                    workout.exercises.removeAll(where: {$0.id == exercise.id})
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                }
            }.navigationTitle("Exercises")
                .overlay {
                    if workout.exercises.isEmpty {
                        ContentUnavailableView {
                            Label("No exercises yet", systemImage: "tray.fill")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addExercise.toggle()
                        } label : {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                        }
                    }
                }
                .sheet(isPresented: $addExercise) {
                    addExerciseView(workout: workout)
                }
        }
        NavigationLink(destination: {
            RestTimerView()
        }) {
                Text("Rest")
                .foregroundColor(.white)
                .frame(width: 200, height: 40)
                .background(Color.green)
                .cornerRadius(15)
                .padding()
        }
    }
}

