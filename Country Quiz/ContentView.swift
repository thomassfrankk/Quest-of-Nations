//
//  ContentView.swift
//  Country Quiz
//
//  Created by Thomas Frank on 19/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var storeKitManager: StoreKitManager
    @Query private var gameSettings: [GameSettings]
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.isPad) private var isPad
    @Environment(\.isSmall) private var isSmall
    @Environment(\.isLandscape) private var isLandscape
    @Environment(\.colorScheme) var colorScheme
    
    @State private var navigateToCountryGame = false
    @State private var navigateToCapitalGame = false
    @State private var navigateToFlipMatchGame = false
    @State private var showSettings = false
    
    private var settings: GameSettings {
        gameSettings.first ?? GameSettings()
    }
    
    func returnToMenu() {
        navigateToCountryGame = false
        navigateToCapitalGame = false
        navigateToFlipMatchGame = false
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo_QoN")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, isLandscape ? 0 : 12)
                
                if !isSmall {
                    Spacer()
                    
                    Image("WorldMap")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.brown.mix(with: .primary, by: 0.7))
                        .padding(isLandscape ? 24 : 32)
                }
                
                Spacer()
                
                // Bottom buttons
                VStack(spacing: 12) {
                    Button {
                        // action for Guess the Country
                        navigateToCountryGame = true
                    } label: {
                        Text("What's the Nation?")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 2)
                    }
                    .tint(.brown.mix(with: .primary, by: 0.7))
                    .buttonStyle(.glassProminent)
                    .controlSize(.large)
                    .frame(maxWidth: 600, alignment: .center)
                    
                    Button {
                        // action for Guess the Capital
                        navigateToCapitalGame = true
                    } label: {
                        Text("What's the Capital?")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 2)
                    }
                    .tint(.brown.mix(with: .primary, by: 0.7))
                    .buttonStyle(.glassProminent)
                    .controlSize(.large)
                    .frame(maxWidth: 600, alignment: .center)
                    
                    Button {
                        navigateToFlipMatchGame = true
                    } label: {
                        Text("Flip & Match")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 2)
                    }
                    .tint(.brown.mix(with: .primary, by: 0.7))
                    .buttonStyle(.glassProminent)
                    .controlSize(.large)
                    .frame(maxWidth: 600, alignment: .center)
                }
                .padding(.top, isLandscape ? 0 : 8)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
                .font(.title3)
                .fontWeight(.bold)
                .tracking(1)
                .foregroundStyle(Color("BackgroundColor").mix(with: Color(UIColor.systemBackground), by: 0.4))
                .fontWeight(.semibold)
                .navigationDestination(isPresented: $navigateToCountryGame) {
                    WhatTheCountryView(onExit: returnToMenu)
                }
                .navigationDestination(isPresented: $navigateToCapitalGame) {
                    WhatTheCapitalView(onExit: returnToMenu)
                }
                .navigationDestination(isPresented: $navigateToFlipMatchGame) {
                    FlipMatchGameView(onExit: returnToMenu)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, isSmall || isPad ? isLandscape ? 16 : 24 : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor").gradient)
            .navigationBarBackButtonHidden()
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView(colorScheme: colorScheme)
                    .environment(\.colorScheme, colorScheme)
            }
            .preferredColorScheme(getColorScheme())
            .onChange(of: storeKitManager.isPremium) { oldValue, newValue in
                if let settings = gameSettings.first {
                    settings.syncPremiumStatus(newValue, in: modelContext)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !settings.isPremium {
                        Button {
                            Task {
                                await storeKitManager.purchasePremium()
                            }
                        } label: {
                            HStack(spacing: 8) {
                                if storeKitManager.isLoading {
                                    ProgressView()
                                        .tint(.primary)
                                } else {
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow.mix(with: .orange, by: 0.5))
                                }
                                
                                Text(storeKitManager.isLoading ? "Processing..." : "Remove ads")
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(.primary)
                            }
                            .frame(width: 160)
                        }
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }
    }
    
    private func getColorScheme() -> ColorScheme? {
        switch settings.displayMode {
        case .light:
            return .light
        case .dark:
            return .dark
        case .auto:
            return nil
        }
    }
    
}

#Preview {
    ContentView()
        .environmentObject(StoreKitManager.shared)
}
