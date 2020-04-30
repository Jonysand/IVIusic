//
//  PlayButtonView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI
import AVKit
import CoreHaptics

struct PlayButtonView: View {
    @EnvironmentObject var PM:PlayerManager
    @Binding var stylusPos:CGPoint
    @Binding var playButtonOffset:CGSize
    
    // haptic feedback
    @State var buttonOffsetStep:Int = 0
    let buttonOffsetStepThresh = 20
    
    var body: some View {
        GeometryReader{ geo in
            HStack(spacing: 0){
                // last song
                ZStack(alignment:.trailing){
                    Rectangle()
                        .foregroundColor(Color.init("PlaybuttonSwitch"))
                        .frame(width: geo.size.width)
                    Image(systemName: "backward.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                // play button
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.init("PlaybuttonPlay"))
                        .frame(width: geo.size.width)
                    Image(systemName: self.PM.isPlaying ? "pause.fill":"play.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                // next song
                ZStack(alignment:.leading){
                    Rectangle()
                        .foregroundColor(Color.init("PlaybuttonSwitch"))
                        .frame(width: geo.size.width)
                    Image(systemName: "forward.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }.edgesIgnoringSafeArea(.horizontal)
        }
        .onTapGesture {
            if(self.PM.musicIndex == -1) {return}
            self.PM.isPlaying.toggle()
            if self.PM.isPlaying {self.PM.player.play()}
            else {self.PM.player.pause()}
            // update stylus position in parallel
            DispatchQueue.global(qos: .background).async {
                while self.PM.isPlaying {
                    self.stylusPos.x = self.PM.timeForLabel + 25
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
        .onChanged{ value in
            self.playButtonOffset = value.translation
            if (Int(self.playButtonOffset.width)/self.buttonOffsetStepThresh != self.buttonOffsetStep){
                do{
                    self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticImpulse))
                    try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                }catch{}
            }
            self.buttonOffsetStep = Int(self.playButtonOffset.width)/self.buttonOffsetStepThresh
        }
        .onEnded{ value in
            if self.playButtonOffset.width < -100 {
                self.PM.musicIndex += 1
                if self.PM.musicIndex >= self.PM.musicList.count {self.PM.musicIndex = 0}
                self.PM.getData()
                self.PM.player.stop()
                self.stylusPos.x = 25
                if self.PM.isPlaying {self.PM.player.play()}
            }else if self.playButtonOffset.width > 100 {
                self.PM.musicIndex -= 1
                if self.PM.musicIndex < 0 {self.PM.musicIndex = self.PM.musicList.count-1}
                self.PM.getData()
                self.PM.player.stop()
                self.stylusPos.x = 25
                if self.PM.isPlaying {self.PM.player.play()}
            }
            self.playButtonOffset = .zero
            }
        )
            .offset(x: self.playButtonOffset.width)
            .animation(.linear)
    }
}
