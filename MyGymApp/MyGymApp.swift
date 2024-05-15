//
//  MyGymAppApp.swift
//  MyGymApp
//
//  Created by Yağız Batu on 24.04.2024.
//

import SwiftUI
import SwiftData
import FirebaseCore


@main
struct MyGymApp: App {
    @AppStorage("uid")
    var userId: String = ""
    
    
    let modelContainer : ModelContainer
    init() {
        do {
            modelContainer = try ModelContainer(for: Workout.self)
            FirebaseApp.configure()
        } catch {
            fatalError("Couldnt init")
        }
    }
    var body: some Scene {
        WindowGroup {
            if userId == "" {
                AuthView()
            } else {
                WorkoutCardView()
            }
            
        }
        .modelContainer(modelContainer)
    }
}
