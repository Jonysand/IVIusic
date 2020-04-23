//
//  DebugSongs.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/20/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import AVKit

struct DebugSongs {
    let song1 = Bundle.main.path(forResource: "Dynasty", ofType: "mp3")
    let song2 = Bundle.main.path(forResource: "Cut In Love", ofType: "mp3")
    let song3 = Bundle.main.path(forResource: "Sansin", ofType: "mp3")
    var songList:[String] = []
    var index:Int = 0
    
    init(){
        songList.append(song1!)
        songList.append(song2!)
        songList.append(song3!)
    }
}
