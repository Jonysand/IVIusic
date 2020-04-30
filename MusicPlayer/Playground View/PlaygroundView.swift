//
//  PlaygroundView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct PlaygroundView: View {
    @EnvironmentObject var PM:PlayerManager
    @State var showWave:Bool = false
    @State var wavePos:CGPoint = .zero
    @State var backgroundReverse:Bool = false
    
    var body: some View {
        ZStack{
            // background to receive tap gesture
            Rectangle()
                .foregroundColor(self.backgroundReverse ? Color.init("ReverseLBcolor"):Color.init("LBcolor"))
                .onLongPressGesture(minimumDuration: 1) {
                    self.backgroundReverse.toggle()
                    do{
                        self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticFadeOut))
                        try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                    }catch{}
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged{value in
                self.showWave = true
                self.wavePos = value.location
            }
            .onEnded{value in
                self.showWave = false
                self.wavePos = value.location
                do{
                    self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticImpulse))
                    try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                }catch{}
            })
            Circle()
                .stroke(lineWidth:2)
                .foregroundColor(self.backgroundReverse ? Color.init("LBcolor"):Color.init("ReverseLBcolor"))
                .frame(width:self.showWave ? 300:0, height:self.showWave ? 300:0)
                .position(self.wavePos)
                .animation(.easeOut)
        }.edgesIgnoringSafeArea(.vertical)
    }
}
