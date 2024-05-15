//
//  Workout.swift
//  MyGymApp
//
//  Created by Yağız Batu on 28.04.2024.
//

import Foundation
import SwiftData

@Model
class Workout {
    var title : String
    var duration : Int
    var exerciseCount: Int
    var difficulty : String
    var date: Date
    var exercises: [Exercise]
    
    init(title: String, duration: Int, exerciseCount: Int, difficulty: String, date: Date, exercises: [Exercise]) {
        self.title = title
        self.duration = duration
        self.exerciseCount = exerciseCount
        self.difficulty = difficulty
        self.date = date
        self.exercises = exercises
    }
}
