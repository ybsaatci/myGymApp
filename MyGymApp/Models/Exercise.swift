//
//  Exercise.swift
//  MyGymApp
//
//  Created by Yağız Batu on 10.05.2024.
//

import Foundation
import Swift
import SwiftData


@Model
class Exercise {
    var name : String
    var sets : Int
    var reps: Int
    var weight : Int
    
    init(name: String, sets: Int, reps: Int, weight: Int) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}

