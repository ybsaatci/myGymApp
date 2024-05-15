//
//  WorkoutView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 9.05.2024.
//

import SwiftUI
import SwiftData

struct WorkoutView: View {
    @Bindable var workout: Workout
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                NavigationLink(destination: {
                    exerciseView(workout: workout)
                }) {
                    
                    Text(workout.title)
                }
                
                
            }
            .lineLimit(1)
            
            Spacer(minLength: 5)
            
            Text(String(workout.duration) + " minutes")
            
        }
    }
}
