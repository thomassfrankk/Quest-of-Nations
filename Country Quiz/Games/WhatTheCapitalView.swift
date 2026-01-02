//
//  GuessTheCapitalView.swift
//  Country Quiz
//
//  Created by Thomas Frank on 20/11/25.
//

import SwiftUI
import SwiftData

struct WhatTheCapitalView: View {
    @Query private var gameSettings: [GameSettings]
    
    @Environment(\.isPad) private var isPad
    @Environment(\.isSmall) private var isSmall
    @Environment(\.isLandscape) private var isLandscape
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var adMobManager: AdMobManager
    @EnvironmentObject var soundManager: SoundManager
    
    let onExit: () -> Void
    
    @State private var countries = Country.allCases
    @State private var currentOptions: [String] = []
    @State private var currentIndex = 0
    @State private var score = 0
    @State private var lives = 3
    @State private var showResult = false
    @State private var selectedAnswer: String?
    @State private var isAnswered = false
    
    @State private var showGameOver = false
    @State private var hapticTrigger: Bool = false
    
    private var highScore: Int {
        gameSettings.first?.getHighScore(for: .capital) ?? 0
    }
    
    private var soundEnabled: Bool {
        gameSettings.first?.isSoundEnabled ?? true
    }
    
    private var hapticsEnabled: Bool {
        gameSettings.first?.isHapticsEnabled ?? true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 0) {
                Text(countries[currentIndex].flag)
                    .font(.system(size: isSmall ?  180 : isPad ? 300 : 200))
                    .minimumScaleFactor(0.7)
                    .shadow(radius: 16)
                    .id(currentIndex)
                    .transition(.push(from: .trailing).combined(with: .opacity))
                
                Text("What is the capital of\n\(countries[currentIndex].name)?")
                    .font(.title)
                    .foregroundStyle(.brown.mix(with: .primary, by: 0.8))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .id(currentIndex)
                    .transition(.scale.combined(with: .opacity))
            }
            
            
            Spacer()
            if !isLandscape {
                Spacer()
            }
            
            VStack(spacing: isSmall ? 12 : 16) {
                // Multiple choice buttons
                ForEach(currentOptions, id: \.self) { option in
                    Button {
                        selectedAnswer = option
                        isAnswered = true
                        checkAnswer(option)
                    } label: {
                        Text(option)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .allowsTightening(true)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                            .frame(minHeight: isSmall ? 55 : isPad ? isLandscape ? 60 : 65 : 60)
                    }
                    .disabled(isAnswered)
                    .frame(maxWidth: 600, alignment: .center)
                    .glassEffect(.regular.tint(buttonColorForOption(option)).interactive(!isAnswered), in: RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.top, isLandscape ? 32 : 0)
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(Color("BackgroundColor").mix(with: Color(UIColor.systemBackground), by: 0.4))
        .padding(.horizontal)
        .padding(.bottom, isSmall || isPad ? 16 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").gradient)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showGameOver) {
            GameOverView(
                gameType: .capital,
                score: score,
                onRetry: resetGame,
                onExit: onExit
            )
        }
        .sensoryFeedback(.success, trigger: hapticTrigger)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            ToolbarSpacer(.fixed, placement: .topBarLeading)
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    withAnimation { gameSettings.first?.isSoundEnabled.toggle() }
                } label: {
                    Image(systemName: soundEnabled ? "speaker.fill" : "speaker.slash.fill")
                        .contentTransition(.symbolEffect(.replace.magic(fallback: .replace)))
                }
            }
            
            ToolbarItem(placement: .principal) {
                heartsDisplay
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Text("\(score)")
                    .font(highScore == 0 ? .title3 : .body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .contentTransition(.numericText(countsDown: false))
                    .animation(.default, value: score)
                    .badge(highScore)
                    .glassEffect(.regular.interactive(false), in: .circle)
            }
        }
        .onAppear {
            soundManager.playSound(soundEnabled ? "start" : "")
            countries = countries.shuffled()
            currentOptions = shuffledOptions()
            let isPremium = gameSettings.first?.isPremium ?? false
            if !isPremium {
                adMobManager.loadInterstitialAd()
            }
        }
    }
    
    private func resetGame() {
        score = 0
        lives = 3
        currentIndex = 0
        currentOptions = shuffledOptions()
        isAnswered = false
        selectedAnswer = nil
        showGameOver = false
    }
    
    private var heartsDisplay: some View {
        HStack(spacing: 8) {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
                .font(.title3)
            
            Text("\(lives)")
                .contentTransition(.numericText(countsDown: true))
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(width: 20, alignment: .center)
        }
        .frame(
            width: 100,
            height: 44
        )
        .glassEffect()
        .animation(.default, value: lives)
    }
    
    private func buttonColorForOption(_ option: String) -> Color {
        guard isAnswered else {
            return .brown.mix(with: .primary, by: 0.6)
        }
        
        let correctAnswer = countries[currentIndex].capital
        
        if option == correctAnswer {
            return Color.green.mix(with: .black, by: 0.1)
        } else if option == selectedAnswer {
            return Color.red.mix(with: .black, by: 0.1)
        }
        
        return .brown.mix(with: .primary, by: 0.6)
    }
    
    /// Generate 4 options: correct capital + 3 mixed from other capitals and major cities
    private func shuffledOptions() -> [String] {
        let country = countries[currentIndex]
        let correctCapital = country.capital
        
        var options: Set<String> = [correctCapital]
        
        // Use major cities from the same country as wrong answers
        for city in country.majorCities.shuffled() {
            if options.count >= 4 {
                break
            }
            options.insert(city)
        }
        
        // Fallback: if country has fewer than 3 major cities, fill from other capitals
        if options.count < 4 {
            let otherCapitals = countries
                .filter { $0 != country }
                .map { $0.capital }
                .shuffled()
            
            for capital in otherCapitals {
                if options.count >= 4 {
                    break
                }
                options.insert(capital)
            }
        }
        
        return Array(options).shuffled()
    }
    
    private func checkAnswer(_ answer: String) {
        if answer == countries[currentIndex].capital {
            score += 1
            soundManager.playSound(soundEnabled ? "correct" : "")
            if hapticsEnabled {
                hapticTrigger.toggle()
            }
        } else {
            lives -= 1
            soundManager.playSound(soundEnabled ? "error" : "")
            if hapticsEnabled {
                triggerErrorHaptic()
            }
        }
        
        if lives <= 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                showGameOver = true
            }
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            nextQuestion()
        }
    }
    
    private func nextQuestion() {
        withAnimation {
            currentIndex = (currentIndex + 1) % countries.count
        }
        
        currentOptions = shuffledOptions()
        isAnswered = false
        selectedAnswer = nil
    }
    
    private func triggerErrorHaptic() {
        let impact = UINotificationFeedbackGenerator()
        impact.notificationOccurred(.error)
    }
}


#Preview {
    NavigationStack {
        WhatTheCapitalView(
            onExit: { }
        )
        .environmentObject(SoundManager.shared)
        .environmentObject(AdMobManager.shared)
    }
}
