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
    
    var body: some View {
        VStack{
            ZStack{
                // default cover
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.rgb(r: 251, g: 195, b: 126))
                    .isHidden(self.PM.musicList[musicIndex].data.count != 0)
                // cover image
                Image(uiImage: (self.PM.musicList[musicIndex].data.count == 0 ? UIImage(systemName: "play.rectangle.fill"):UIImage(data: self.PM.musicList[musicIndex].data))!)
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .isHidden(self.PM.musicList[musicIndex].data.count == 0)
            }.overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 10)
                .foregroundColor(Color.init("LBcolor"))
                .blur(radius: 10)
            )
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .foregroundColor(Color.init("ReverseLBcolor"))
                .opacity(0.1)
                .blur(radius: 1)
            )
        }
    }
}
