//
//  VisualizeManager.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 5/3/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import AVFoundation

class VisualizeManager:ObservableObject{
    private var timer: Timer?
    private var currentSample: Int
    private let numberOfSamples: Int
    
    @Published public var soundSamples: [Float]
    
    init(numberOfSamples:Int) {
        self.numberOfSamples = numberOfSamples
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func startMonitoring(PM:PlayerManager) {
        PM.player.isMeteringEnabled = true
        if timer != nil {timer?.invalidate()}
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            PM.player.updateMeters()
            self.soundSamples[self.currentSample] = (PM.player.averagePower(forChannel: 0) + PM.player.averagePower(forChannel: 1))/2
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    
    func stopMonitoring(PM:PlayerManager) {
        PM.player.isMeteringEnabled = false
        timer?.invalidate()
    }
}
