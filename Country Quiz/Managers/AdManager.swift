//
//  AdMobManager.swift
//  Country Quiz
//
//  Created by Thomas Frank on 01/01/26.
//

import GoogleMobileAds
import SwiftUI
import Combine
import os.log

private let logger = Logger(subsystem: "com.thomasfrank.countryquiz", category: "AdMobManager")

@MainActor
class AdMobManager: NSObject, ObservableObject {
    static let shared = AdMobManager()
    
    @Published var interstitialAd: InterstitialAd?
    @Published var isAdLoaded = false
    
    // Callback when ad is dismissed
    var onAdDismissed: (() -> Void)?
    
    // Flag to use test ads (set to false for production)
    static let useTestAds = true
    
    private let secretsManager = SecretsManager.shared
    
    // Computed properties to select correct IDs
    var currentInterstitialAdUnitID: String {
        secretsManager.getAdMobInterstitialAdUnitID(useTestAds: Self.useTestAds)
    }
    
    var currentAppID: String {
        secretsManager.getAdMobAppID(useTestAds: Self.useTestAds)
    }
    
    override init() {
        super.init()
        setupGoogleMobileAds()
    }
    
    func setupGoogleMobileAds() {
        MobileAds.shared.start(completionHandler: nil)
        logger.info("AdMob initialized with \(AdMobManager.useTestAds ? "TEST" : "PRODUCTION") ads")
    }
    
    func loadInterstitialAd() {
        let request = Request()
        
        InterstitialAd.load(with: currentInterstitialAdUnitID,
                            request: request,
                            completionHandler: { [weak self] ad, error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if let error = error {
                    logger.error("Failed to load interstitial ad: \(error.localizedDescription)")
                    self.isAdLoaded = false
                    return
                }
                
                self.interstitialAd = ad
                self.isAdLoaded = true
                ad?.fullScreenContentDelegate = self
                logger.debug("Interstitial ad loaded successfully")
            }
        })
    }
    
    func showInterstitialAd(from viewController: UIViewController) {
        guard let ad = interstitialAd else {
            logger.warning("Interstitial ad is not loaded yet, loading now")
            loadInterstitialAd()
            return
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            ad.present(from: rootViewController)
        }
    }
}

extension AdMobManager: FullScreenContentDelegate {
    nonisolated func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        logger.info("Interstitial ad was dismissed")
        
        DispatchQueue.main.async { [weak self] in
            // Call the callback when ad is dismissed
            self?.onAdDismissed?()
            
            // Load next ad
            self?.loadInterstitialAd()
        }
    }
    
    nonisolated func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        logger.error("Interstitial ad failed to present: \(error.localizedDescription)")
        
        DispatchQueue.main.async { [weak self] in
            // Call callback even if ad fails
            self?.onAdDismissed?()
            self?.loadInterstitialAd()
        }
    }
}
