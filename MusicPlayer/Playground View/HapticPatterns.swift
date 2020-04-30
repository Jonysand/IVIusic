//
//  HapticPatterns.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/27/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import CoreHaptics

struct HapticPatterns {
    let hapticFadeOut = [
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
    
    let hapticImpulse = [
        CHHapticPattern.Key.pattern: [
            [CHHapticPattern.Key.event:
                [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                  CHHapticPattern.Key.time: 0.001,
                  CHHapticPattern.Key.eventDuration: 1.0]
            ]
        ]
    ]
}

