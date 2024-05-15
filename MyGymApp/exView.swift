//
//  exView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 10.05.2024.
//

import SwiftUI

struct exView: View {
    @Bindable var ex : Exercise
    var body: some View {
        NavigationLink(destination: {
            editExerciseView(ex: ex)
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(ex.name)
                    
                    
                }
                .lineLimit(1)
                Spacer(minLength: 5)
                Text(String(ex.sets) + " Sets")
                Spacer(minLength: 5)
                Text(String(ex.reps) + " Reps ")
                Spacer(minLength: 5)
                Text(String(ex.weight) + " lbs")
            }
            
        }
    }
}
