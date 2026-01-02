///
//  StoreKitManager.swift
//  Country Quiz
//
//  Created by Thomas Frank on 01/01/26.
//

import StoreKit
import SwiftUI
import Combine
import os.log

@MainActor
class StoreKitManager: NSObject, ObservableObject {
    static let shared = StoreKitManager()
    
    private let logger = Logger(subsystem: "com.thomasfrank.questofnations", category: "StoreKit")
    
    @Published var isPremium = false
    @Published var isLoading = false
    @Published var error: String?
    @Published var productPrice: String = "..."
    
    // Replace with your actual Product ID from App Store Connect
    static let premiumProductID = "com.thomasfrank.questofnations.premium"
    
    private var updateListenerTask: Task<Void, Error>? = nil
    
    override init() {
        super.init()
        setupListeners()
        Task {
            await loadPremiumStatus()
            await fetchProductPrice()
        }
    }
    
    func setupListeners() {
        updateListenerTask = Task(priority: .background) { [weak self] in
            for await result in Transaction.updates {
                do {
                    let transaction = try self?.checkVerified(result)
                    await self?.updatePremiumStatus()
                    
                    await transaction?.finish()
                } catch {
                    self?.logger.error("Transaction failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(let unverified, _):
            logger.warning("Unverified transaction")
            return unverified
        case .verified(let verified):
            return verified
        }
    }
    
    func loadPremiumStatus() async {
        await updatePremiumStatus()
    }
    
    private func updatePremiumStatus() async {
        var hasPremium = false
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if transaction.productID == Self.premiumProductID {
                    hasPremium = true
                    logger.debug("Premium entitlement found")
                }
            } catch {
                logger.error("Error checking entitlements: \(error.localizedDescription)")
            }
        }
        
        self.isPremium = hasPremium
        logger.debug("Premium status updated: \(hasPremium)")
    }
    
    func fetchProductPrice() async {
        do {
            let products = try await Product.products(for: [Self.premiumProductID])
            
            if let product = products.first {
                self.productPrice = product.displayPrice
                logger.debug("Product price fetched: \(product.displayPrice)")
            }
        } catch {
            logger.error("Error fetching product price: \(error.localizedDescription)")
            self.productPrice = "..."
        }
    }
    
    func purchasePremium() async {
        isLoading = true
        error = nil
        
        logger.debug("Starting premium purchase")
        
        do {
            guard let product = try await Product.products(for: [Self.premiumProductID]).first else {
                error = "Product not found"
                logger.error("Premium product not found on App Store")
                isLoading = false
                return
            }
            
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                do {
                    let transaction = try checkVerified(verification)
                    await updatePremiumStatus()
                    await transaction.finish()
                    logger.info("Premium purchase successful")
                } catch {
                    self.error = "Purchase verification failed"
                    logger.error("Purchase verification failed: \(error.localizedDescription)")
                }
                
            case .userCancelled:
                logger.debug("User cancelled premium purchase")
                
            case .pending:
                logger.debug("Premium purchase is pending")
                
            @unknown default:
                error = "Unknown purchase result"
                logger.error("Unknown purchase result")
            }
        } catch {
            self.error = error.localizedDescription
            logger.error("Premium purchase failed: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func restorePurchases() async {
        isLoading = true
        error = nil
        
        logger.debug("Starting restore purchases")
        
        do {
            try await AppStore.sync()
            await updatePremiumStatus()
            logger.info("Purchases restored successfully")
        } catch {
            self.error = "Restore failed: \(error.localizedDescription)"
            logger.error("Restore purchases failed: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
}
