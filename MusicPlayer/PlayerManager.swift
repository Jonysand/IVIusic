//
//  PlayerManager.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/20/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import AVKit

class PlayerManager: ObservableObject {
    @Published var isPlaying:Bool = false
    var player: AVAudioPlayer!
    
    // meta data of the song playing
    @Published var data:Data = .init(count: 0)
    @Published var title:String = "Music Title"
    
    // haptic mananger
    var hapticManager:HapticManager = HapticManager()
    
    // songs for ddebugging without file system
    var debugSongs:DebugSongs = DebugSongs()
    
    // controling the progress bar
    let screenWdith = UIScreen.main.bounds.width - 50
    var currentTime:CGFloat { get {return CGFloat(player.currentTime / player.duration)} }
    var timeForLabel:CGFloat {get {return CGFloat(currentTime) * screenWdith}}
    
    
    func getData(){
        let asset = AVAsset(url: URL(fileURLWithPath: self.debugSongs.songList[self.debugSongs.index]))
        self.title = "Unnamed"
        self.data = .init(count: 0)
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
