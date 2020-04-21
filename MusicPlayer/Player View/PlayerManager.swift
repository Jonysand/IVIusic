//
//  PlayerManager.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/20/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import AVKit

struct PlayerManager {
    var isPlaying:Bool = false
    var player: AVAudioPlayer!
    var stylusPos:CGPoint = .zero
    
    // meta data of the song playing
    var data:Data = .init(count: 0)
    var title:String = ""
    
    // songs for ddebugging without file system
    var debugSongs:DebugSongs = DebugSongs()
    
    // controling the progress bar
    let screenWdith = UIScreen.main.bounds.width - 25
    var currentTime:CGFloat { get {return CGFloat(player.currentTime / player.duration)} }
    var timeForLabel:CGFloat {get {return CGFloat(currentTime) * screenWdith}}
    
    mutating func getData(){
        let asset = AVAsset(url: URL(fileURLWithPath: self.debugSongs.songList[self.debugSongs.index]))
        for i in asset.commonMetadata{
            if i.commonKey?.rawValue == "artwork"{
                self.data = i.value as! Data
            }
            if i.commonKey?.rawValue == "title"{
                self.title = i.value as! String
            }
        }
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: self.debugSongs.songList[self.debugSongs.index]))
    }
}
