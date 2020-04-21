//
//  PlaygroundView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct PlaygroundView: View {
    @State var showWave:Bool = false
    @State var wavePos:CGPoint = .zero
    var hapticManager:HapticManager = HapticManager()
    
    var body: some View {
        ZStack{
            // background to receive tap gesture
            Rectangle()
                .foregroundColor(.black)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged{value in
                        self.showWave = true
                        self.wavePos = value.location
                    }
                    .onEnded{value in
                        self.showWave = false
                        self.wavePos = value.location
                        do{ try self.hapticManager.player.start(atTime: 0)}catch{}
                })
            Circle()
                .stroke(lineWidth:2)
                .foregroundColor(.white)
                .frame(width:self.showWave ? 300:0, height:self.showWave ? 300:0)
                .position(self.wavePos)
                .animation(.easeOut)
        }
    }
}

//struct PlaygroundView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaygroundView()
//    }
//}
