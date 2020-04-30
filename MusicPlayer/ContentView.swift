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
    var body: some View {
        TabView{
            MusicListView()
                .tabItem{
                    Image(systemName: "music.note.list")
                    Text("Music")
                        .font(.headline)
            }
            PlaygroundView()
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
