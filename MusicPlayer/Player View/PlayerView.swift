//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @EnvironmentObject var PM:PlayerManager
    @State var stylusPos:CGPoint = .zero
    @State var playButtonOffset = CGSize.zero
    var currentMusicIndex:Int
    
    var body: some View {
        
            GeometryReader{geo in
                VStack{
                    Spacer()
                    //------------
                    // player view
                    //------------
                    ZStack(alignment:.bottom){
                        // Main Player view
                        VStack{
                            // music title
                            VStack{
                                Text(self.PM.title)
                                    .foregroundColor(Color.init("ReverseLBcolor"))
                                    .font(.custom("Helvetica", size: 22))
                                    .fontWeight(.black)
                                Text(self.PM.author)
                                    .foregroundColor(Color.init("ReverseLBcolorLight"))
                                    .font(.custom("Helvetica", size: 18))
                                    .fontWeight(.bold)
                            }
                            .padding()
                            Spacer()
                            // album cover
                            DiscView()
                                .rotationEffect(.degrees(Double(-self.playButtonOffset.width) * 0.9))
                                .frame(width: geo.size.height/2, height:geo.size.height/2)
                            Spacer()
                            // Gramo View
                            GramoView(stylusPos: self.$stylusPos)
                            Divider()
                            // play button
                            PlayButtonView(stylusPos: self.$stylusPos, playButtonOffset: self.$playButtonOffset)
                                .frame(height: 80)
                        }
                    }.animation(.linear)
                        .onAppear{
                            if(self.currentMusicIndex != self.PM.musicIndex){
                                self.PM.musicIndex = self.currentMusicIndex
                                if(self.PM.player != nil){self.PM.player.stop()}
                                self.PM.getData()
                                self.PM.isPlaying = true
                                self.PM.effectPlayer.play()
                                self.PM.player.play()
                                DispatchQueue.global(qos: .background).async {
                                    while self.PM.isPlaying {
                                        self.stylusPos.x = self.PM.timeForLabel + 25
                                    }
                                }
                            }
                            else if (self.PM.isPlaying){
                                DispatchQueue.global(qos: .background).async {
                                    while self.PM.isPlaying {
                                        self.stylusPos.x = self.PM.timeForLabel + 25
                                    }
                                }
                            }
                    }
                }
            }
        
        
    }
}
