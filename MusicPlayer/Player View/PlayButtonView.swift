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
    
    // flag for haptic when switching the song
    @State var switchSongHaptic = false
    
    // flag for indicator of dragability, false after launch
    @State var initAnimation = true
    
    let offsetThresh:CGFloat = 80
    
    var body: some View {
        GeometryReader{ geo in
            HStack(spacing: 0){
                // last song
                ZStack(alignment:.trailing){
                    Rectangle()
                        .foregroundColor(Color.init("LBcolorLight"))
                        .frame(width: geo.size.width)
                    if(self.playButtonOffset.width > self.offsetThresh || self.initAnimation){
                        Image(systemName: "backward")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .transition(.moveAndFadeLeft)
                    }
                }.offset(x: self.initAnimation ? 100:0)
                // play button
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.init("LBcolorLight"))
                        .frame(width: geo.size.width)
                    Image(systemName: self.PM.isPlaying ? "pause":"play")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                // next song
                ZStack(alignment:.leading){
                    Rectangle()
                        .foregroundColor(Color.init("LBcolorLight"))
                        .frame(width: geo.size.width)
                    if(self.playButtonOffset.width < -self.offsetThresh || self.initAnimation){
                        Image(systemName: "forward")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .transition(.moveAndFadeRight)
                    }
                }.offset(x: self.initAnimation ? -100:0)
            }.edgesIgnoringSafeArea(.horizontal)
        }
        .onAppear{
            self.initAnimation.toggle()
        }
        .onTapGesture {
            if(self.PM.musicIndex == -1) {return}
            self.PM.isPlaying.toggle()
            if self.PM.isPlaying {
                self.PM.effectPlayer.play()
                self.PM.player.play()
            }
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
            if self.playButtonOffset.width < -self.offsetThresh && !self.switchSongHaptic{
                self.switchSongHaptic = true
                do{
                    self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticImpulse))
                    try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                }catch{}
            }else if self.playButtonOffset.width > self.offsetThresh && !self.switchSongHaptic{
                self.switchSongHaptic = true
                do{
                    self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticImpulse))
                    try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                }catch{}
            }else if(self.playButtonOffset.width <= self.offsetThresh && self.playButtonOffset.width >= -self.offsetThresh){
                self.switchSongHaptic = false
            }
            
        }
        .onEnded{ value in
            if self.playButtonOffset.width < -self.offsetThresh {
                // next song
                self.PM.musicIndex += 1
                if self.PM.musicIndex >= self.PM.musicList.count {self.PM.musicIndex = 0}
                self.PM.getData()
                self.PM.player.stop()
                self.stylusPos.x = 25
                if self.PM.isPlaying {
                    self.PM.effectPlayer.play()
                    self.PM.player.play()
                }
                do{
                    self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticImpulse))
                    try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                }catch{}
            }else if self.playButtonOffset.width > self.offsetThresh {
                // last song
                self.PM.musicIndex -= 1
                if self.PM.musicIndex < 0 {self.PM.musicIndex = self.PM.musicList.count-1}
                self.PM.getData()
                self.PM.player.stop()
                self.stylusPos.x = 25
                if self.PM.isPlaying {
                    self.PM.effectPlayer.play()
                    self.PM.player.play()
                }
                do{
                    self.PM.hapticManager.HapticPlayer = try self.PM.hapticManager.hapticEngine.makePlayer(with: try CHHapticPattern(dictionary: self.PM.hapticManager.hapticPatterns.hapticImpulse))
                    try self.PM.hapticManager.HapticPlayer.start(atTime: 0)
                }catch{}
            }
            self.playButtonOffset = .zero
            }
        )
            .offset(x: self.playButtonOffset.width)
            .animation(.linear)
    }
}


extension AnyTransition {
    static var moveAndFadeLeft: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
    static var moveAndFadeRight: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
