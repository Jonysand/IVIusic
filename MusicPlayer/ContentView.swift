//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var PM:PlayerManager
    @State var backgroundReverse:Bool = false
    var body: some View {
        TabView{
            MusicListView()
                .tabItem{
                    Image(systemName: "music.note.list")
                    Text("Music")
                        .font(.headline)
            }
            VStack{
                Spacer(minLength: 96)
                PlayerView(currentMusicIndex: self.PM.musicIndex)
            }
            .tabItem{
                Image(systemName: "play.circle")
                Text("Playing")
                    .font(.headline)
            }
            ZStack{
                PlaygroundView(backgroundReverse: self.$backgroundReverse)
                MusicVisualizeView(backgroundReverse: self.$backgroundReverse)
            }
            .tabItem{
                Image(systemName: "waveform.path.ecg")
                Text("Playground")
                    .font(.headline)
            }
        }.animation(.linear)
            .onAppear{
                self.PM.getData()
        }
    }
}
