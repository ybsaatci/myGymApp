//
//  GroupedWorkouts.swift
//  MyGymApp
//
//  Created by Yağız Batu on 28.04.2024.
//

import SwiftUI
import SwiftData

// Data model that holds grouped workouts by their dates
// Used to filter and group workouts by their calendar date
struct GroupedWorkouts: Identifiable {
    var id : UUID = .init()
    var date: Date
    var workouts : [Workout]
    
    
    var groupTitle: String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return date.formatted(date: .abbreviated,time: .omitted)
        }
    }
}

