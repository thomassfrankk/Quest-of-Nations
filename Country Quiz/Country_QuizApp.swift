//
//  Country_QuizApp.swift
//  Country Quiz
//
//  Created by Thomas Frank on 01/01/26.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct Country_QuizApp: App {
    @StateObject private var orientationObserver = OrientationObserver()
    @StateObject private var adMobManager = AdMobManager.shared
    @StateObject private var storeKitManager = StoreKitManager.shared
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: GameSettings.self)
            
            let modelContext = ModelContext(modelContainer)
            _ = GameSettings.getOrCreate(in: modelContext)
        } catch {
            fatalError("Could not initialize SwiftData: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .environmentObject(orientationObserver)
                .environmentObject(adMobManager)
                .environmentObject(storeKitManager)
                .environmentObject(SoundManager.shared)
                .environment(\.screenHeight, UIScreen.currentHeight)
                .environment(\.isPad, UIScreen.isPad)
                .environment(\.isSmall, UIScreen.isSmall)
                .environment(\.isLandscape, orientationObserver.isLandscape)
                .onAppear {
                    UIDevice.current.beginGeneratingDeviceOrientationNotifications()
                }
        }
    }
}
