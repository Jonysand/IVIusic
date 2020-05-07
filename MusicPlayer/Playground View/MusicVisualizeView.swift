//
//  MusicVisualizeView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 5/3/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI
import AVKit

struct MusicVisualizeView: View {
    @EnvironmentObject var PM:PlayerManager
    @ObservedObject var VM = VisualizeManager(numberOfSamples: 9)
    @Binding var backgroundReverse:Bool
    
    let circleBounds:CGFloat = 40
    
    var body: some View {
        VStack{
            HStack{
                // left top
                VStack{
                    ForEach(0..<7, id:\.self){row in
                        HStack{
                            ForEach(0..<4, id:\.self){col in
                                Circle()
                                    .scale(self.normalizeSoundLevel(level: self.VM.soundSamples[(9-col-row)/2]), anchor: .center)
                                    .frame(width:self.circleBounds, height:self.circleBounds)
                            }
                        }
                    }
                }
                // right top
                VStack{
                    ForEach(0..<7, id:\.self){row in
                        HStack{
                            ForEach(0..<4, id:\.self){col in
                                Circle()
                                    .scale(self.normalizeSoundLevel(level: self.VM.soundSamples[(col+6-row)/2]), anchor: .center)
                                    .frame(width:self.circleBounds, height:self.circleBounds)
                            }
                        }
                    }
                }
            }
            HStack{
                // left bottom
                VStack{
                    ForEach(0..<7, id:\.self){row in
                        HStack{
                            ForEach(0..<4, id:\.self){col in
                                Circle()
                                    .scale(self.normalizeSoundLevel(level: self.VM.soundSamples[(3-col+row)/2]), anchor: .center)
                                    .frame(width:self.circleBounds, height:self.circleBounds)
                            }
                        }
                    }
                }
                // right bottom
                VStack{
                    ForEach(0..<7, id:\.self){row in
                        HStack{
                            ForEach(0..<4, id:\.self){col in
                                Circle()
                                    .scale(self.normalizeSoundLevel(level: self.VM.soundSamples[(col+row)/2]), anchor: .center)
                                    .frame(width:self.circleBounds, height:self.circleBounds)
                            }
                        }
                    }
                }
            }
        }
        .foregroundColor(self.backgroundReverse ? Color.init("LBcolorLight"):Color.init("ReverseLBcolorLight"))
        .onAppear{
            if self.PM.player == nil {return}
            if self.PM.isPlaying {
                self.VM.startMonitoring(PM:self.PM)
            }
        }
        .onDisappear(){
            if self.PM.player == nil {return}
            self.VM.stopMonitoring(PM: self.PM)
        }
        .drawingGroup(opaque: false)
    }
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(2, level + 20) / 2
        return CGFloat(level/80)
    }
}
