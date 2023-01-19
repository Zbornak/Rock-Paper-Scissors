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
            .font(.system(size: 50))
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
    @State private var computerChoice = ""
    @State private var userShouldLose = Bool.random()
    @State private var userScore = 0
    @State private var showingScore = false
    @State private var tieAlert = false
    @State private var endGame = false
    @State private var didUserWin = true
    
    private var computerChoices = ["rock", "paper", "scissors"].shuffled()
    
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
        } else if userChoice == "scissors" {
            return "✂️"
        } else {
            return "💭"
        }
    }
    
    func displayComputerChoice() -> String {
        if computerChoice == "rock" {
            return "🪨"
        } else if computerChoice == "paper" {
            return "📄"
        } else if computerChoice == "scissors" {
            return "✂️"
        } else {
            return "💭"
        }
    }
    
    func playerWins() {
        userScore += 1
        toggleAlerts()
        didUserWin = true
    }
    
    func computerChoiceMaker() {
        if computerChoice == "rock" && userShouldLose && userChoice == "paper" {
            playerWins()
            toggleAlerts()
        } else if computerChoice == "rock" && !userShouldLose && userChoice == "scissors" {
            playerWins()
            toggleAlerts()
        } else if computerChoice == "rock" && userChoice == "rock" {
            //tie
            tieAlert.toggle()
        } else if computerChoice == "paper" && userShouldLose && userChoice == "scissors" {
            playerWins()
            toggleAlerts()
        } else if computerChoice == "paper" && !userShouldLose && userChoice == "rock" {
            playerWins()
            toggleAlerts()
        } else if computerChoice == "paper" && userChoice == "paper" {
            //tie
            tieAlert.toggle()
        } else if computerChoice == "scissors" && userShouldLose && userChoice == "paper" {
            playerWins()
            toggleAlerts()
        } else if computerChoice == "scissors" && !userShouldLose && userChoice == "rock" {
            playerWins()
            toggleAlerts()
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
                    VStack {
                        Text("Make your choice:")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("取捨選択をする")
                            .fontWeight(.bold)
                    }
                    .padding()
                }
                        
                Section {
                    HStack {
                        Button("🪨") {
                            userChoice = "rock"
                            computerChoice = computerChoices[0]
                            computerChoiceMaker()
                        }
                        .buttonStyle()
                                
                        Button("📄") {
                            userChoice = "paper"
                            computerChoice = computerChoices[0]
                            computerChoiceMaker()
                        }
                        .buttonStyle()
                                
                        Button("✂️") {
                            userChoice = "scissors"
                            computerChoice = computerChoices[0]
                            computerChoiceMaker()
                        }
                        .buttonStyle()
                    }
                }
                
                Section {
                    HStack {
                        VStack {
                            Text("My choice was:")
                                .fontWeight(.bold)
                            Text("わたしが選んだ")
                            Text(displayComputerChoice())
                                .font(.system(size: 100))
                        }
                        .padding()
                        
                        VStack {
                            Text("Your choice was:")
                                .fontWeight(.bold)
                            Text("あなたが選んだ")
                            Text(displayUserChoice())
                                .font(.system(size: 100))
                        }
                        .padding()
                    }
                }
                .shadow(radius: 30)
                        
                Section {
                    Text("Score スコア: \(userScore)")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
   
            VStack {
                Spacer()
                Image("rock_paper_scissors")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
        }
        .navigationTitle("じゃんけん❗️")
        .navigationBarTitleDisplayMode(.inline)
    }
    .alert("\(computerChoice) beats \(userChoice), you \(returnUserWin())!", isPresented: $showingScore) {
        Button("Continue") {
            computerChoice = "💭"
            userChoice = "💭"
        }
            } message: {
                Text("Your score is \(userScore)")
        }
        
    .alert("WINNER!", isPresented: $endGame) {
        Button("Start again") {
            computerChoice = "💭"
            userChoice = "💭"
        }
            } message: {
                Text("Congratulations, that's 10 in a row!")
        }
        
    .alert("Tie!", isPresented: $tieAlert) {
        Button("Contiue") {
            computerChoice = "💭"
            userChoice = "💭"
        }
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
