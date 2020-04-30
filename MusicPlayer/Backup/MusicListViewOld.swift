//
//  MusicListView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/20/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//


import SwiftUI
import AVKit

struct MusicListView: View {
    @EnvironmentObject var PM:PlayerManager
    @State private var scrollViewContentOffset:CGFloat = 0
    @State var showingPlayer = false
    
    var body: some View {
        NavigationView{
            TrackableScrollView(.horizontal, showIndicators: false, contentOffset: $scrollViewContentOffset){
                HStack{
                    ForEach(0..<self.PM.musicList.count, id:\.self){thisIndex in
                        VStack(alignment: .center){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.clear)
                                MusicItemView(musicIndex: thisIndex, scrollOffset:self.scrollViewContentOffset-CGFloat(400*thisIndex-400))
                                    .frame(width: 300, height: 300)
                            }.onTapGesture {
                                self.PM.musicIndex = thisIndex
                                self.PM.player.stop()
                                self.PM.getData()
                                self.PM.isPlaying = true
                                self.PM.player.play()
                            }
                            .frame(width: 400, height: 400)
                            Text(self.PM.musicList[thisIndex].title)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationBarTitle("Browse Music")
        }
    }
}
