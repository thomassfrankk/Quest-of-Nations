//
//  SoundManager.swift
//  Country Quiz
//
//  Created by Thomas Frank on 02/01/26.
//

import AVFoundation
import os.log
import Combine

class SoundManager: NSObject, AVAudioPlayerDelegate, ObservableObject {
    static let shared = SoundManager()
    
    private var audioPlayer: AVAudioPlayer?
    private let logger = Logger(subsystem: "com.thomasfrank.countryquiz", category: "SoundManager")
    
    override private init() {
        super.init()
    }
    
    func playSound(_ soundName: String) {
        guard !soundName.isEmpty else { return }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            logger.warning("Sound file not found: \(soundName).wav")
            return
        }
        
        do {
            // Activate audio session with duck others only when playing sound
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, options: .duckOthers)
            try audioSession.setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            
            logger.debug("Playing sound: \(soundName)")
        } catch {
            logger.error("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    // MARK: - AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Optional: Deactivate audio session when done playing
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            logger.error("Error deactivating audio session: \(error.localizedDescription)")
        }
    }
}
