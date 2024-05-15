//
//  ContentView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 24.04.2024.
//

import SwiftUI

struct RestTimerView: View {
    @State private var timeRemain : TimeInterval = 60
    @State private var timer : Timer?
    @State private var isRunning : Bool = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .stroke(.white,lineWidth: 20)
                        .opacity(0.3)
                    Circle()
                        .trim(from: 0, to: CGFloat(1 - timeRemain / 60))
                        .stroke(.green, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    Text(formattedTime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 500)
                
                HStack {
                    Button {
                        isRunning.toggle()
                        if isRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    } label: {
                        Image(systemName: isRunning ? "stop.fill" : "play.fill")
                            .foregroundStyle(.foreground)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                    }
                    Button {
                        resetTimer()
                    } label : {
                        Text("Reset")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 40)
                            .background(Color.green)
                            .cornerRadius(15)
                            .padding()
                    }
                }
            }
            .padding(.horizontal, 30)
            .navigationTitle("Resting Timer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func formattedTime() -> String {
        let mins = Int(timeRemain) / 60
        let second = Int(timeRemain) % 60
        return String(format: "%02d:%02d", mins, second)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemain > 0 {
                timeRemain -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
    }
    
    private func resetTimer() {
        timeRemain = 60
        isRunning = false
        timer?.invalidate()
    }
}

