//
//  HapticManager.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/20/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import CoreHaptics

class HapticManager{
    var hapticEngine:CHHapticEngine!
    var pattern: CHHapticPattern!
    var HapticPlayer: CHHapticPatternPlayer!
    let hapticPatterns = HapticPatterns()
    
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
        hapticEngine.resetHandler = {
            print("Reset Handler: Restarting the engine.")
            do {
                // Try restarting the engine.
                try self.hapticEngine.start()
            } catch {
                fatalError("Failed to restart the engine: \(error)")
            }
        }
        do{
            pattern = try CHHapticPattern(dictionary: self.hapticPatterns.hapticImpulse)
            HapticPlayer = try hapticEngine.makePlayer(with: pattern)
            try hapticEngine.start()
        }catch{}
    }
}
