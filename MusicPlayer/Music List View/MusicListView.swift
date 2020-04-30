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
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    VStack{
                        HStack{
                            ForEach(0..<self.PM.musicList.count, id:\.self){thisIndex in
                                NavigationLink(destination: PlayerView(currentMusicIndex: thisIndex)){
                                    VStack(alignment: .center){
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(.clear)
                                            MusicItemView(musicIndex: thisIndex)
                                                .frame(width: 300, height: 300)
                                        }
                                        .frame(width: 400, height: 400)
                                        VStack(alignment: .leading){
                                            Text(self.PM.musicList[thisIndex].title)
                                                .foregroundColor(Color.init("ReverseLBcolor"))
                                                .font(.custom("Helvetica", size: 22))
                                                .fontWeight(.black)
                                            Text(self.PM.musicList[thisIndex].author)
                                                .foregroundColor(Color.init("ReverseLBcolorLight"))
                                                .font(.custom("Helvetica", size: 18))
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }.navigationBarTitle("Browse Music")
            .navigationBarItems(trailing:
                NavigationLink(destination: PlayerView(currentMusicIndex: self.PM.musicIndex)){
                    Image(systemName: "play.circle.fill")
                        .imageScale(.large)                }
            )
        }
    }
}
