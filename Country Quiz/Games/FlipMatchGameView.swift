//
//  FlipMatchGameView.swift
//  Country Quiz
//
//  Created by Thomas Frank on 30/12/25.
//

import SwiftUI
import SwiftData

// MARK: - Card Model

struct MatchCard: Identifiable, Equatable {
    let id: Int
    var country: Country
    var isFaceUp = false
    var isMatched = false
    
    static func == (lhs: MatchCard, rhs: MatchCard) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Game Phase

enum GamePhase {
    case ready
    case preview
    case playing
    case roundComplete
}

// MARK: - Game View Model

@Observable
class FlipMatchViewModel {
    var cards: [MatchCard] = []
    var firstFlippedIndex: Int?
    var isProcessing = false
    var matchedPairs = 0
    var round = 1
    var phase: GamePhase = .ready
    
    var pairsNeeded: Int {
        // Round 1: 6 pairs (3x4), Round 2+: 9 pairs (3x6)
        round == 1 ? 6 : 9
    }
    
    var rows: Int {
        // Round 1: 4 rows, Round 2+: 6 rows
        round == 1 ? 4 : 6
    }
    
    var isRoundComplete: Bool {
        matchedPairs == pairsNeeded
    }
    
    init() {
        setupRound()
    }
    
    func setupRound() {
        let selectedCountries = Array(Country.allCases.shuffled().prefix(pairsNeeded))
        
        var newCards: [MatchCard] = []
        var cardId = 0
        for country in selectedCountries {
            newCards.append(MatchCard(id: cardId, country: country))
            cardId += 1
            newCards.append(MatchCard(id: cardId, country: country))
            cardId += 1
        }
        
        cards = newCards.shuffled()
        firstFlippedIndex = nil
        isProcessing = false
        matchedPairs = 0
        phase = .ready
    }
    
    func showPreview() {
        phase = .preview
        for i in cards.indices {
            cards[i].isFaceUp = true
        }
    }
    
    func startPlaying() {
        for i in cards.indices {
            cards[i].isFaceUp = false
        }
        phase = .playing
    }
    
    var secondFlippedIndex: Int?
    
    func flipAllCardsDown() {
        for i in cards.indices {
            cards[i].isFaceUp = false
        }
    }
    
    func cancelCurrentFlip() {
        // Flip back both cards
        if let firstIndex = firstFlippedIndex {
            cards[firstIndex].isFaceUp = false
        }
        if let secondIndex = secondFlippedIndex {
            cards[secondIndex].isFaceUp = false
        }
        firstFlippedIndex = nil
        secondFlippedIndex = nil
        isProcessing = false
    }
    
    func resetMatchedState() {
        for i in cards.indices {
            cards[i].isMatched = false
        }
    }
    
    func shuffleNewCountries() {
        let selectedCountries = Array(Country.allCases.shuffled().prefix(pairsNeeded))
        var countryPairs: [Country] = []
        for country in selectedCountries {
            countryPairs.append(country)
            countryPairs.append(country)
        }
        countryPairs.shuffle()
        
        // Update existing cards with new countries
        for i in cards.indices {
            cards[i].country = countryPairs[i]
            cards[i].isMatched = false
            cards[i].isFaceUp = false
        }
        
        firstFlippedIndex = nil
        isProcessing = false
        matchedPairs = 0
        phase = .ready
    }
    
    func addNewRows() {
        round += 1
        
        // Keep existing cards, just reset them with new countries
        let existingCount = cards.count
        let newTotalCards = pairsNeeded * 2
        let cardsToAdd = newTotalCards - existingCount
        
        // Get new countries for ALL cards (existing + new)
        let selectedCountries = Array(Country.allCases.shuffled().prefix(pairsNeeded))
        var countryPairs: [Country] = []
        for country in selectedCountries {
            countryPairs.append(country)
            countryPairs.append(country)
        }
        countryPairs.shuffle()
        
        // Update existing cards with new countries (first 12)
        for i in 0..<existingCount {
            cards[i].country = countryPairs[i]
            cards[i].isMatched = false
            cards[i].isFaceUp = false
        }
        
        // Add new cards (the extra 6)
        let startId = existingCount
        for i in 0..<cardsToAdd {
            let newCard = MatchCard(
                id: startId + i,
                country: countryPairs[existingCount + i]
            )
            cards.append(newCard)
        }
        
        firstFlippedIndex = nil
        isProcessing = false
        matchedPairs = 0
        phase = .ready
    }
    
    func resetGame() {
        round = 1
        setupRound()
    }
    
    enum FlipResult {
        case firstCard
        case match(Country)
        case noMatch
    }
    
    func flipCard(at index: Int) -> FlipResult? {
        guard phase == .playing,
              !cards[index].isFaceUp,
              !cards[index].isMatched else { return nil }
        
        cards[index].isFaceUp = true
        
        if let firstIndex = firstFlippedIndex {
            // Second card flipped
            secondFlippedIndex = index
            isProcessing = true
            
            if cards[firstIndex].country == cards[index].country {
                let matchedCountry = cards[index].country
                cards[firstIndex].isMatched = true
                cards[index].isMatched = true
                matchedPairs += 1
                firstFlippedIndex = nil
                secondFlippedIndex = nil
                isProcessing = false
                
                if isRoundComplete {
                    phase = .roundComplete
                }
                
                return .match(matchedCountry)
            } else {
                // No match - will flip back after delay (or when user taps third card)
                let firstIdx = firstIndex
                let secondIdx = index
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    // Only flip back if these cards are still the current attempt
                    if self.firstFlippedIndex == firstIdx && self.secondFlippedIndex == secondIdx {
                        self.cards[firstIdx].isFaceUp = false
                        self.cards[secondIdx].isFaceUp = false
                        self.firstFlippedIndex = nil
                        self.secondFlippedIndex = nil
                        self.isProcessing = false
                    }
                }
                return .noMatch
            }
        } else {
            // First card flipped
            firstFlippedIndex = index
            return .firstCard
        }
    }
}

// MARK: - Game View

struct FlipMatchGameView: View {
    @Query private var gameSettings: [GameSettings]
    
    @Environment(\.isPad) private var isPad
    @Environment(\.isSmall) private var isSmall
    @Environment(\.isLandscape) private var isLandscape
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var adMobManager: AdMobManager
    @EnvironmentObject var soundManager: SoundManager
    
    let onExit: () -> Void
    
    @State private var viewModel = FlipMatchViewModel()
    @State private var score = 0
    @State private var lives = 5
    @State private var livesIncreasing = false
    @State private var showGameOver = false
    @State private var gameText: String = "Get Ready"
    @State private var hapticTrigger: Bool = false
    @State private var livesBounceTrigger: Int = 0
    
    private let pointsPerMatch = 1
    
    private var highScore: Int {
        gameSettings.first?.getHighScore(for: .match) ?? 0
    }
    
    private var soundEnabled: Bool {
        gameSettings.first?.isSoundEnabled ?? true
    }
    
    private var hapticsEnabled: Bool {
        gameSettings.first?.isHapticsEnabled ?? true
    }
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 12
            let columns = 3
            let rows = viewModel.rows
            
            let totalHorizontalSpacing = spacing * CGFloat(columns - 1)
            let totalVerticalSpacing = spacing * CGFloat(rows - 1)
            
            let availableWidth = geometry.size.width - 32 - totalHorizontalSpacing
            let availableHeight = geometry.size.height - totalVerticalSpacing
            
            let cardWidth = availableWidth / CGFloat(columns)
            let cardHeight = availableHeight / CGFloat(rows)
            
            let gridColumns = Array(repeating: GridItem(.fixed(cardWidth), spacing: spacing), count: columns)
            
            LazyVGrid(columns: gridColumns, spacing: spacing) {
                ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
                    CardView(card: card) {
                        handleCardTap(at: index)
                    }
                    .frame(width: cardWidth, height: cardHeight)
                    .transition(.push(from: .bottom))
                }
            }
            .padding(.horizontal)
            
            .animation(.easeInOut(duration: 0.4), value: viewModel.cards.count)
        }
        .padding(.bottom, isSmall || isPad ? 16 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").gradient)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showGameOver) {
            GameOverView(
                gameType: .match,
                score: score,
                onRetry: resetGame,
                onExit: onExit
            )
        }
        .sensoryFeedback(.success, trigger: hapticTrigger)
        .safeAreaBar(edge: .top, content: {
            VStack {
                Text(gameText)
                    .font(.headline)
                    .id(gameText)
                    .transition(.scale)
            }
            .animation(.default, value: gameText)
            .padding(.top, 8)
            .padding(.bottom)
        })
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
            startRound()
            
            let isPremium = gameSettings.first?.isPremium ?? false
            if !isPremium {
                adMobManager.loadInterstitialAd()
            }
        }
    }
    
    // MARK: - Game Flow
    
    private func resetGame() {
        score = 0
        lives = 5
        livesIncreasing = false
        showGameOver = false
        gameText = "Get Ready"
        hapticTrigger = false
        livesBounceTrigger = 0
        viewModel = FlipMatchViewModel()
    }
    
    private func startRound() {
        gameText = "Get Ready"
        soundManager.playSound(soundEnabled ? "start" : "")
        
        // Wait a moment, then show preview
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                gameText = "Memorize"
                viewModel.showPreview()
                soundManager.playSound(soundEnabled ? "mediumPop" : "")
                if hapticsEnabled {
                    hapticTrigger.toggle()
                }
            }
            
            // After 3 seconds of preview, hide cards and start playing
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation {
                    viewModel.startPlaying()
                    gameText = "Round \(viewModel.round)"
                    soundManager.playSound(soundEnabled ? "mediumPop" : "")
                    if hapticsEnabled {
                        hapticTrigger.toggle()
                    }
                }
            }
        }
    }
    
    private func handleCardTap(at index: Int) {
        // If two cards are showing (processing), cancel and start fresh with this card
        if viewModel.isProcessing {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.cancelCurrentFlip()
            }
        }
        
        guard let result = viewModel.flipCard(at: index) else { return }
        
        switch result {
        case .firstCard:
            soundManager.playSound(soundEnabled ? "mediumPop" : "")
            if hapticsEnabled {
                hapticTrigger.toggle()
            }
            
        case .match(let country):
            withAnimation {
                score += pointsPerMatch
                gameText = "\(country.name)"
            }
            soundManager.playSound(soundEnabled ? "correct" : "")
            if hapticsEnabled {
                hapticTrigger.toggle()
            }
            
            // Check if round is complete
            if viewModel.isRoundComplete {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    startNextRound()
                }
            } else {
                // Show country name for 2 seconds, then go back to round text
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        gameText = "Round \(viewModel.round)"
                    }
                }
            }
            
        case .noMatch:
            withAnimation {
                livesIncreasing = false
                lives -= 1
            }
            soundManager.playSound(soundEnabled ? "error" : "")
            if hapticsEnabled {
                triggerErrorHaptic()
            }
            
            // Check for game over
            if lives <= 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showGameOver = true
                }
            } else {
                // Reset game text after a moment
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        gameText = "Round \(viewModel.round)"
                    }
                }
            }
        }
    }
    
    private func startNextRound() {
        let isFirstRound = viewModel.round == 1
        
        // Step 1: Show completion message
        withAnimation {
            gameText = "Round Complete"
        }
        
        // Step 2: Flip all cards back
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.4)) {
                viewModel.flipAllCardsDown()
                viewModel.resetMatchedState()
                soundManager.playSound(soundEnabled ? "mediumPop" : "")
                if hapticsEnabled {
                    hapticTrigger.toggle()
                }
            }
        }
        
        // Step 3: Add lives bonus
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                livesIncreasing = true
                lives += 3
                gameText = "+3 Lives"
                livesBounceTrigger += 1
                soundManager.playSound(soundEnabled ? "life" : "")
                if hapticsEnabled {
                    hapticTrigger.toggle()
                }
            }
        }
        
        // Step 4: Change flags while face down (for round 1 only, also add new rows)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            gameText = "Get Ready"
            
            if isFirstRound {
                // Add new rows with animation
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.addNewRows()
                    soundManager.playSound(soundEnabled ? "longPop" : "")
                    if hapticsEnabled {
                        hapticTrigger.toggle()
                    }
                }
                
                // Step 5: Show preview (3 seconds preview)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        gameText = "Memorize"
                        viewModel.showPreview()
                        soundManager.playSound(soundEnabled ? "mediumPop" : "")
                        if hapticsEnabled {
                            hapticTrigger.toggle()
                        }
                    }
                }
                
                // Step 6: Start playing (after 3 seconds of preview)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        viewModel.startPlaying()
                        gameText = "Round \(viewModel.round)"
                        soundManager.playSound(soundEnabled ? "mediumPop" : "")
                        if hapticsEnabled {
                            hapticTrigger.toggle()
                        }
                    }
                }
            } else {
                // Just shuffle new countries
                viewModel.shuffleNewCountries()
                soundManager.playSound(soundEnabled ? "longPop" : "")
                if hapticsEnabled {
                    hapticTrigger.toggle()
                }
                
                // Step 5: Show preview (3 seconds preview)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        gameText = "Memorize"
                        viewModel.showPreview()
                        soundManager.playSound(soundEnabled ? "mediumPop" : "")
                        if hapticsEnabled {
                            hapticTrigger.toggle()
                        }
                    }
                }
                
                // Step 6: Start playing (after 3 seconds of preview)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        viewModel.startPlaying()
                        gameText = "Round \(viewModel.round)"
                        soundManager.playSound(soundEnabled ? "mediumPop" : "")
                        if hapticsEnabled {
                            hapticTrigger.toggle()
                        }
                    }
                }
            }
        }
    }
    
    private var heartsDisplay: some View {
        HStack(spacing: 8) {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
                .font(.title3)
                .id(livesBounceTrigger)
                .symbolEffect(.bounce, value: livesBounceTrigger)
            
            Text("\(lives)")
                .contentTransition(.numericText(countsDown: !livesIncreasing))
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(width: 20, alignment: .center)
        }
        .frame(width: 100, height: 44)
        .glassEffect()
        .animation(.default, value: lives)
    }
    
    private func triggerErrorHaptic() {
        let impact = UINotificationFeedbackGenerator()
        impact.notificationOccurred(.error)
    }
}

// MARK: - Card View

struct CardView: View {
    @Environment(\.isPad) private var isPad
    let card: MatchCard
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                // Card back
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("ReverseCowGirl").gradient)
                    .overlay {
                        Image(systemName: "globe")
                            .font(.system(size: isPad ? 75 : 50))
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(Color("BackgroundColor"))
                    }
                    .opacity(card.isFaceUp ? 0 : 1)
                
                // Card front
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("ReverseCowGirl").gradient)
                    .opacity(card.isMatched ? 0.6 : 1)
                    .overlay {
                        Text(card.country.flag)
                            .font(.system(size: isPad ? 125 : 75))
                            .minimumScaleFactor(0.5)
                    }
                    .opacity(card.isFaceUp ? 1 : 0)
            }
            .rotation3DEffect(
                .degrees(card.isFaceUp ? 0 : 180),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 0.3), value: card.isFaceUp)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FlipMatchGameView(
            onExit: { }
        )
        .environmentObject(SoundManager.shared)
        .environmentObject(AdMobManager.shared)
    }
}
