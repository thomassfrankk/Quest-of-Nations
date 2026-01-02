//
//  SettingsView.swift
//  Country Quiz
//
//  Created by Thomas Frank on 01/01/26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Query private var gameSettings: [GameSettings]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var storeKitManager: StoreKitManager
    
    let colorScheme: ColorScheme
    
    private var settings: GameSettings {
        gameSettings.first ?? GameSettings()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Subscription Section
                    SettingsSectionView(title: "Premium") {
                        if settings.isPremium {
                            HStack(spacing: 16) {
                                Image(systemName: "crown.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.orange)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Premium Quest Master")
                                        .font(.headline)
                                    Text("Enjoy ad-free gameplay • Thanks for your support!")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical)
                        } else {
                            VStack(spacing: 16) {
                                    VStack(alignment: .center, spacing: 8) {
                                        Text("Go Premium")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        Text("Remove all ads • \(storeKitManager.productPrice)")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                
                                Button {
                                    Task {
                                        await storeKitManager.purchasePremium()
                                    }
                                } label: {
                                    HStack(spacing: 8) {
                                        if storeKitManager.isLoading {
                                            ProgressView()
                                                .tint(colorScheme == .dark ? .black : .white)
                                        } else {
                                            Image(systemName: "crown.fill")
                                                .font(.body)
                                        }
                                        
                                        Text(storeKitManager.isLoading ? "Processing..." : "Unlock Premium")
                                            .font(.headline)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .foregroundStyle(colorScheme == .dark ? .black : .white)
                                }
                                .tint(Color("ReverseCowGirl"))
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.capsule)
                                .padding([.top, .horizontal])
                                
                                Button {
                                    Task {
                                        await storeKitManager.restorePurchases()
                                    }
                                } label: {
                                    Text("Restore Purchases")
                                        .font(.footnote.weight(.semibold))
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    // Display Mode Section
                    SettingsSectionView(title: "Display") {
                        Picker("Display Mode", selection: .init(
                            get: { settings.displayMode },
                            set: {
                                settings.displayMode = $0
                                try? modelContext.save()
                            }
                        )) {
                            Text("Auto").tag(DisplayMode.auto)
                            Text("Light").tag(DisplayMode.light)
                            Text("Dark").tag(DisplayMode.dark)
                        }
                        
                        .pickerStyle(.segmented)
                    }
                    
                    // Audio & Haptics Section
                    SettingsSectionView(title: "Audio & Haptics") {
                        VStack(spacing: 24) {
                            SettingsToggleRow(
                                label: "Sound Effects",
                                isEnabled: settings.isSoundEnabled
                            ) {
                                settings.isSoundEnabled.toggle()
                                try? modelContext.save()
                            }
                            
                            SettingsToggleRow(
                                label: "Haptic Feedback",
                                isEnabled: settings.isHapticsEnabled
                            ) {
                                settings.isHapticsEnabled.toggle()
                                try? modelContext.save()
                            }
                        }
                        .tint(Color("ReverseCowGirl"))
                    }
                    
                    // High Scores Section
                    SettingsSectionView(title: "High Scores") {
                        VStack(spacing: 16) {
                            HStack {
                                Text("Country Quiz: \(settings.countryGameHighScore)")
                                    .font(.body.weight(.medium))
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                Button {
                                    settings.countryGameHighScore = 0
                                    try? modelContext.save()
                                } label: {
                                    Text("Reset")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                                        .padding(.horizontal)
                                }
                                .tint(Color("ReverseCowGirl"))
                                .buttonStyle(.borderedProminent)
                                .padding(.leading, 32)
                            }
                            
                            HStack {
                                Text("Capital Quiz: \(settings.capitalGameHighScore)")
                                    .font(.body.weight(.medium))
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                Button {
                                    settings.capitalGameHighScore = 0
                                    try? modelContext.save()
                                } label: {
                                    Text("Reset")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                                        .padding(.horizontal)
                                }
                                .tint(Color("ReverseCowGirl"))
                                .buttonStyle(.borderedProminent)
                                .padding(.leading, 32)
                            }
                            
                            HStack {
                                Text("Flip Match: \(settings.matchGameHighScore)")
                                    .font(.body.weight(.medium))
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                Button {
                                    settings.matchGameHighScore = 0
                                    try? modelContext.save()
                                } label: {
                                    Text("Reset")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                                        .padding(.horizontal)
                                }
                                .tint(Color("ReverseCowGirl"))
                                .buttonStyle(.borderedProminent)
                                .padding(.leading, 32)
                            }
                        }
                    }
                    
                    // Privacy & Legal Section
                    SettingsSectionView(title: "Legal") {
                        HStack(spacing: 0) {
                            NavigationLink(destination: PrivacyPolicyView()) {
                                HStack {
                                    Text("Privacy Policy")
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
                .padding()
                .animation(.default, value: settings.displayMode)
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor").gradient)
            .navigationBarBackButtonHidden()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
            .onChange(of: storeKitManager.isPremium) { oldValue, newValue in
                if let settings = gameSettings.first {
                    settings.syncPremiumStatus(newValue, in: modelContext)
                }
            }
        }
    }
}

// MARK: - Components

struct SettingsSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
                .frame(maxWidth: 600, alignment: .leading)
            
            content
                .foregroundStyle(.primary)
                
                .padding()
                .frame(maxWidth: 600, alignment: .leading)
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 15))
                
        }
        .frame(maxWidth: .infinity)
    }
}

struct SettingsToggleRow: View {
    let label: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Toggle(label, isOn: .init(
                get: { isEnabled },
                set: { _ in action() }
            ))
        }
    }
}

struct HighScoreRow: View {
    let gameName: String
    let score: Int
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(gameName)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            Text("\(score)")
                .font(.headline.weight(.bold))
                .foregroundStyle(.blue)
        }
    }
}

// MARK: - Privacy Policy View

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Privacy Policy")
                        .font(.title2.weight(.bold))
                        .padding(.bottom, 8)
                    
                    Text("Your privacy is important to us. This privacy policy explains our data practices.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Data Collection")
                            .font(.headline)
                        Text("We collect information necessary to provide our services, including gameplay data and preferences.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Data Usage")
                            .font(.headline)
                        Text("Your data is used to improve your experience, maintain game progress, and provide features you requested.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Data Protection")
                            .font(.headline)
                        Text("We implement security measures to protect your information from unauthorized access.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor").gradient)
            .navigationBarBackButtonHidden()
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SettingsView(colorScheme: .light)
            .modelContainer(for: GameSettings.self, inMemory: true)
            .environmentObject(StoreKitManager.shared)
    }
}
