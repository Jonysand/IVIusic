//
//  GramoView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/20/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct GramoView: View {
    @Binding var PM:PlayerManager
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                // simulate disc
                Rectangle()
                    .frame(width: geo.size.width, height:10)
                    .position(x: geo.size.width/2, y:2 * geo.size.height/3+50)
                
                // stylus
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 40, height: 100)
                    .onAppear(perform: {
                        self.PM.stylusPos = .init(x: 25, y: 2 * geo.size.height/3)
                    })
                    .position(x: self.PM.stylusPos.x, y: self.PM.isPlaying ? self.PM.stylusPos.y : self.PM.stylusPos.y - 30)
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged{value in
                            self.PM.stylusPos.x = value.location.x
                            if self.PM.stylusPos.x < 25 {self.PM.stylusPos.x = 25}
                            if self.PM.stylusPos.x > self.PM.screenWdith {self.PM.stylusPos.x = self.PM.screenWdith}
                            self.PM.stylusPos.y = 2 * geo.size.height/3 - 20
                            
                            // change progress
                            self.PM.player.pause()
                            self.PM.isPlaying = false
                    }
                    .onEnded{value in
                        self.PM.stylusPos.x = value.location.x
                        self.PM.stylusPos.y = 2 * geo.size.height/3
                        
                        // continue playing at where the stylus is
                        let currentTime = Double((self.PM.stylusPos.x - 25)/self.PM.screenWdith) * self.PM.player.duration
                        self.PM.player.currentTime = currentTime
                        self.PM.isPlaying = true
                        self.PM.player.play()
                        DispatchQueue.global(qos: .background).async {
                            while self.PM.isPlaying {
                                self.PM.stylusPos.x = self.PM.timeForLabel + 25
                            }
                        }
                    })
                    .animation(.linear)
            }
        }
    }
}
