//
//  GameOverView.swift
//  Country Quiz
//
//  Created by Thomas Frank on 01/01/26.
//

import SwiftUI
import SwiftData
import AVFoundation
import StoreKit

struct GameOverView: View {
    @Query private var gameSettings: [GameSettings]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var adMobManager: AdMobManager
    
    @Environment(\.isPad) private var isPad
    @Environment(\.isSmall) private var isSmall
    @Environment(\.isLandscape) private var isLandscape
    
    @AppStorage("lastReviewRequestDate") private var lastReviewDate: Double = 0
    
    let gameType: GameType
    let score: Int
    let onRetry: () -> Void
    let onExit: () -> Void
    
    @State private var returnToMenu: Bool = false
    @State private var isNewHighScore: Bool = false
    @State private var showFullContent: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var soundPlayed: Bool = false
    
    private var settings: GameSettings {
        gameSettings.first ?? GameSettings()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                Text("Game Over")
                    .font(.custom("SairaStencilOne-Regular", size: 120))
                    .foregroundStyle(.brown.mix(with: .primary, by: 0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                    .padding(.top, isSmall ? 0 : 8)
                
                if showFullContent {
                    VStack(spacing: 48) {
                        Image(systemName: "medal.fill")
                            .font(.system(size: isSmall ? 140 : 180))
                            .foregroundStyle(.brown.mix(with: .primary, by: 0.7))
                        
                        if isPad && !isLandscape {
                            Spacer()
                        }
                        
                        VStack(spacing: -16) {
                            Text("\(score)")
                                .font(.custom("SairaStencilOne-Regular", size: isSmall ? 70 : 100))
                                .contentTransition(.numericText())
                            
                            Text(isNewHighScore ? "NEW HIGHSCORE" : "SCORE")
                                .font(.custom("SairaStencilOne-Regular", size: 24))
                                .transition(.scale.combined(with: .opacity))
                            
                            if !isNewHighScore {
                                Text("HIGHSCORE: \(settings.getHighScore(for: gameType))")
                                    .foregroundStyle(.secondary)
                                    .font(.custom("SairaStencilOne-Regular", size: 20))
                                    .transition(.scale.combined(with: .opacity))
                                    .padding(.top, 24)
                            }
                        }
                        .foregroundStyle(.brown.mix(with: .primary, by: 0.7))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 4)
                                .foregroundStyle(.brown.mix(with: .primary, by: 0.7))
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Button(action: onRetry) {
                            Text("Play Again")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                        }
                        .tint(.brown.mix(with: .primary, by: 0.7))
                        .buttonStyle(.glassProminent)
                        .controlSize(.large)
                        .foregroundStyle(Color("BackgroundColor").mix(with: Color(UIColor.systemBackground), by: 0.1))
                        
                        Button(action: onExit) {
                            Text("Back to Menu")
                                .foregroundStyle(.brown.mix(with: .primary, by: 0.7))
                                .font(.title3.weight(.semibold))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                    }
                } else {
                    Spacer()
                }
            }
            .frame(maxWidth: 600, maxHeight: .infinity)
        }
        .navigationDestination(isPresented: $returnToMenu) {
            ContentView()
        }
        .padding(.horizontal)
        .padding(.bottom, isSmall || isPad ? 16 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").gradient)
        .navigationBarBackButtonHidden()
        .onAppear {
            checkAndSaveHighScore()
            showAdIfNeeded()
        }
    }
    
    private func checkAndSaveHighScore() {
        guard let settings = gameSettings.first else { return }
        
        let currentHighScore = settings.getHighScore(for: gameType)
        
        if score > currentHighScore {
            isNewHighScore = true
            settings.updateHighScore(for: gameType, score: score)
            try? modelContext.save()
        }
    }
    
    private func showAdIfNeeded() {
        let isPremium = settings.isPremium
        let adLoaded = adMobManager.isAdLoaded
        
        // Show content immediately if premium OR if ad is not loaded
        if isPremium || !adLoaded {
                showFullContent = true

            // Play tada sound if new high score
            if isNewHighScore && settings.isSoundEnabled && !soundPlayed {
                playTadaSound()
                soundPlayed = true
                // Request review after 2 second delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    requestReviewIfNeeded()
                }
            }
        } else {
            // Ad is loaded and user is not premium - show ad first
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // Set callback to show content when ad is dismissed
                let dismissCallback = {
                    withAnimation {
                        showFullContent = true
                    }
                    // Play tada sound after ad is dismissed if new high score
                    if isNewHighScore && settings.isSoundEnabled && !soundPlayed {
                        playTadaSound()
                        soundPlayed = true
                        // Request review after 2 second delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            requestReviewIfNeeded()
                        }
                    }
                }
                
                adMobManager.onAdDismissed = dismissCallback
                
                // Show ad
                adMobManager.showInterstitialAd(from: UIViewController())
            }
        }
    }
    
    private func playTadaSound() {
        guard let soundURL = Bundle.main.url(forResource: "tada", withExtension: "wav") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            return
        }
    }
    
    private func requestReviewIfNeeded() {
        guard isNewHighScore else { return }
        
        let now = Date().timeIntervalSince1970
        
        // Only allow request if last request is more than 24 hours ago
        if now - lastReviewDate >= 24 * 60 * 60 {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                AppStore.requestReview(in: scene)
            }
            
            // Update last request time
            lastReviewDate = now
        }
    }
}

#Preview {
    NavigationStack {
        GameOverView(
            gameType: .capital,
            score: 18,
            onRetry: {
                print("Retry tapped")
            },
            onExit: {
                print("Exit tapped")
            }
        )
        .modelContainer(for: GameSettings.self, inMemory: true)
        .environmentObject(AdMobManager.shared)
    }
}
