//
//  MusicItemView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/28/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct MusicItemView: View {
    @EnvironmentObject var PM:PlayerManager
    var musicIndex:Int
    var scrollOffset:CGFloat
    
    var body: some View {
        VStack{
            ZStack{
                // default cover
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.rgb(r: 251, g: 195, b: 126))
                    .isHidden(self.PM.musicList[musicIndex].data.count != 0)
                // cover image
                Image(uiImage: (self.PM.musicList[musicIndex].data.count == 0 ? UIImage(systemName: "play.rectangle.fill"):UIImage(data: self.PM.musicList[musicIndex].data))!)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .isHidden(self.PM.musicList[musicIndex].data.count == 0)
            }.overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 5)
                .foregroundColor(Color.init("LBcolor"))
                .blur(radius: 5))
                .scaleEffect(self.scrollOffset/400 > 1 ? (2-self.scrollOffset/400 > 0 ? 2-self.scrollOffset/400 : 1) : self.scrollOffset < 0 ? 0.1 : self.scrollOffset/400)
//                .offset(x: scrollOffset < 400 ? scrollOffset - 400 : 0, y: 0)
        }
    }
}
