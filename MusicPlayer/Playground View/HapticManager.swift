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
    var player: CHHapticPatternPlayer!
    
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do { hapticEngine = try CHHapticEngine()
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
        let hapticDict = [
            CHHapticPattern.Key.pattern: [
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.001,
                      CHHapticPattern.Key.eventDuration: 1.0] // End of first event
                ], // End of first dictionary entry in the array
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.101,
                      CHHapticPattern.Key.eventDuration: 1.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.201,
                      CHHapticPattern.Key.eventDuration: 2.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.401,
                      CHHapticPattern.Key.eventDuration: 2.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.601,
                      CHHapticPattern.Key.eventDuration: 3.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.901,
                      CHHapticPattern.Key.eventDuration: 3.0]
                ]
            ] // End of array
        ] // End of haptic dictionary
        do{
            pattern = try CHHapticPattern(dictionary: hapticDict)
            player = try hapticEngine.makePlayer(with: pattern)
            try hapticEngine.start()
        }catch{}
    }
}
