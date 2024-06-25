//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aaron Thompson on 21/06/2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showAlert = false
    @State private var showFinalScoreAlert = false
    
    @State private var index = 0
    @State private var round = 1
    @State private var score = 0
    
    @State var flags = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer  = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    @ViewBuilder var flagImage: some View {
        ForEach(0..<3) { number in
            Button {
                flagTapped(number)
            } label: {
                Image( flags[number] )
            }
        }
    }
    
    var body: some View {
        
            ZStack {
                LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom ).ignoresSafeArea()
                
                VStack {
                    Text("Round \(round)").foregroundStyle(.white).font(.largeTitle.bold())
                    Spacer()
                    
                    VStack {
                        Text("Guess the flags").foregroundStyle(Color.white).font(.subheadline.weight(.heavy))
                        
                        Text(flags[correctAnswer]).foregroundStyle(.white).font(.largeTitle.weight(.semibold))
                        
                        flagImage.clipShape(.capsule).shadow(radius: 5)
                    }
                    Spacer()
                }
                
            }.alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue" , action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }.alert("Game over", isPresented: $showFinalScoreAlert) {
                Button("Restart" , action: resetGame)
            } message: {
                Text("Your overall score is \(score)/8")
            }
        
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(flags[number]),"
        }
        
        if round == 8 {
            showFinalScoreAlert = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        flags.shuffle()
        correctAnswer = Int.random(in: 0...2)
        round += 1
    }
    
    func resetGame() {
        score = 0
        round = 1
        flags.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
#Preview {
    ContentView()
}
