//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mark Strijdom on 17/01/2023.
//

import SwiftUI

struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .font(.largeTitle)
            .background(Color(red: 254.0 / 255.0, green: 222.0 / 255.0, blue: 121.0 / 255.0))
            .shadow(radius: 30)
            .padding()
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(CustomButton())
    }
}

struct ContentView: View {
    @State private var userChoice = ""
    @State private var computerChoice = "rock"
    @State private var userShouldLose = Bool.random()
    @State private var userScore = 0
    @State private var showingScore = false
    @State private var tieAlert = false
    @State private var endGame = false
    
    private var computerChoices = ["rock", "paper", "scissors"]
    private var userChoices = ["rock", "paper", "scissors"]
    private var didUserWin = true
    
    func returnUserWin() -> String {
       if didUserWin == true {
           return "win"
       } else {
           return "lose"
       }
    }
    
    func toggleAlerts() {
        if userScore < 10 {
            showingScore.toggle()
        } else {
            endGame.toggle()
            userScore = 0
        }
    }
    
    func displayUserChoice() -> String {
        if userChoice == "rock" {
            return "🪨"
        } else if userChoice == "paper" {
            return "📄"
        } else {
            return "✂️"
        }
    }
    
    func displayComputerChoice() -> String {
        if computerChoice == "rock" {
            return "🪨"
        } else if computerChoice == "paper" {
            return "📄"
        } else {
            return "✂️"
        }
    }
    
    mutating func computerRockChoice() {
        if computerChoice == "rock" && userShouldLose && userChoice == "paper" {
            //player wins
            userScore += 1
            toggleAlerts()
            didUserWin = true
        } else if computerChoice == "rock" && !userShouldLose && userChoice == "scissors" {
            //player wins
            userScore += 1
            toggleAlerts()
            didUserWin = true
        } else if computerChoice == "rock" && userChoice == "rock" {
            //tie
            tieAlert.toggle()
        } else {
            //player loses
            userScore = 0
            toggleAlerts()
            didUserWin = false
        }
    }
    
    mutating func computerPaperChoice() {
        if computerChoice == "paper" && userShouldLose && userChoice == "scissors" {
            //player wins
            userScore += 1
            toggleAlerts()
            didUserWin = true
        } else if computerChoice == "paper" && !userShouldLose && userChoice == "rock" {
            //player wins
            userScore += 1
            toggleAlerts()
            didUserWin = true
        } else if computerChoice == "paper" && userChoice == "paper" {
            //tie
            tieAlert.toggle()
        } else {
            //player loses
            userScore = 0
            toggleAlerts()
            didUserWin = false
        }
    }
    
    mutating func computerScissorsChoice() {
        if computerChoice == "scissors" && userShouldLose && userChoice == "paper" {
            //player wins
            userScore += 1
            toggleAlerts()
            didUserWin = true
        } else if computerChoice == "scissors" && !userShouldLose && userChoice == "rock" {
            //player wins
            userScore += 1
            toggleAlerts()
            didUserWin = true
        } else if computerChoice == "scissors" && userChoice == "scissors" {
            //tie
            tieAlert.toggle()
        } else {
            //player loses
            userScore = 0
            toggleAlerts()
            didUserWin = false
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 254.0 / 255.0, green: 222.0 / 255.0, blue: 121.0 / 255.0), Color(red: 254.0 / 255.0, green: 222.0 / 255.0, blue: 121.0 / 255.0), .teal]), startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                
            VStack {
                Section {
                    Text("Make your choice")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }
                        
                Section {
                    HStack {
                        Button("🪨") {
                            userChoice = "rock"
                            toggleAlerts()
                        }
                        .buttonStyle()
                                
                        Button("📄") {
                            userChoice = "paper"
                            toggleAlerts()
                        }
                        .buttonStyle()
                                
                        Button("✂️") {
                            userChoice = "scissors"
                            toggleAlerts()
                        }
                        .buttonStyle()
                    }
                }
                
                Section {
                    HStack {
                        VStack {
                            Text("My choice was:")
                                .fontWeight(.bold)
                            Text(displayComputerChoice())
                                .font(.system(size: 100))
                        }
                        .padding()
                        
                        VStack {
                            Text("Your choice was:")
                                .fontWeight(.bold)
                            Text(displayUserChoice())
                                .font(.system(size: 100))
                        }
                        .padding()
                    }
                }
                .shadow(radius: 30)
                        
                Section {
                    Text("Score: \(userScore)")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
   
            VStack {
                Spacer()
                Image("rock_paper_scissors")
            }
        }
        .navigationTitle("Rock, Paper, Scissors")
        .navigationBarTitleDisplayMode(.inline)
    }
    .alert("Rock beats scissors, you \(returnUserWin())!", isPresented: $showingScore) {
        Button("Continue") {}
            } message: {
                Text("Your score is \(userScore)")
        }
        
    .alert("WINNER!", isPresented: $endGame) {
        Button("Start again") {}
            } message: {
                Text("Congratulations, that's 10 in a row!")
        }
        
    .alert("Tie!", isPresented: $tieAlert) {
        Button("Contiue") {}
            } message: {
                Text("Ooh, we chose the same, no-one wins!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
