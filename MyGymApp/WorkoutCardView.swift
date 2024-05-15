//
//  WorkoutCardView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 24.04.2024.
//

import SwiftUI
import SwiftData
import FirebaseAuth
struct WorkoutCardView: View {
    @Query(sort: [SortDescriptor(\Workout.date, order: .reverse)],
           animation: .snappy) private var allWorkouts: [Workout]
    
    @State private var groupedWorkouts : [GroupedWorkouts] = []
    @Environment(\.modelContext) private var context
    @State private var addWorkout : Bool = false
    @AppStorage("uid")
    var userId: String = ""
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach($groupedWorkouts) { $group in
                    Section(group.groupTitle) {
                        ForEach(group.workouts) { workout in
                            WorkoutView(workout: workout)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        context.delete(workout)
                                        withAnimation {
                                            group.workouts.removeAll(where: {$0.id == workout.id})
                                            
                                            if group.workouts.isEmpty {
                                                groupedWorkouts.removeAll(where: { $0.id == group.id})
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                }
            }.navigationTitle("Workouts")
                .overlay {
                    if allWorkouts.isEmpty || groupedWorkouts.isEmpty {
                        ContentUnavailableView {
                            Label("No Workouts yet", systemImage: "tray.fill")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addWorkout.toggle()
                        } label : {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            let firebaseAuth = Auth.auth()
                            withAnimation {
                                userId = ""
                            }
                            
                            do {
                                try firebaseAuth.signOut()
                            } catch let signOutError as NSError {
                                print("Error signing out %@", signOutError)
                            }
                        } label: {
                            Text("Sign out")
                        }
                    }
                }
        }
        .onChange(of: allWorkouts, initial: true) { oldVal, newVal in
            if newVal.count > oldVal.count || groupedWorkouts.isEmpty {
                createGroupedWorkouts(newVal)
            }
            
        }
        .sheet(isPresented: $addWorkout) {
            addWorkoutView()
        }
    }
    
    // Some of the snippets of code are taken from
    // https://www.youtube.com/watch?v=Mpenbt2mH-Y tutorial
    // Mainly creating date grouped data model efficiently
    func createGroupedWorkouts(_ workouts: [Workout]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: workouts) { workout in
                let dateComp = Calendar.current.dateComponents([.day, .month, .year], from: workout.date)
                
                return dateComp
            }
            
            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            await MainActor.run {
                groupedWorkouts = sortedDict.compactMap({ dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return .init(date: date, workouts: dict.value)
                })
            }
        }
    }
}


