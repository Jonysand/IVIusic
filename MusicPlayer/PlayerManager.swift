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
    var effectPlayer: AVAudioPlayer!
    
    // meta data of the song playing
    @Published var data:Data = .init(count: 0)
    @Published var title:String = "Title"
    @Published var author:String = "Artist"
    
    // list of music scanned
    var musicList:[eachSong] = []
    var musicIndex:Int = -1
    
    // haptic mananger
    var hapticManager:HapticManager = HapticManager()
    
    // controling the progress bar
    let screenWdith = UIScreen.main.bounds.width - 50
    var currentTime:CGFloat { get {return CGFloat(player.currentTime / player.duration)} }
    var timeForLabel:CGFloat {get {return CGFloat(currentTime) * screenWdith}}
    
    init(){
        // load sound effect
        let gramoSound = Bundle.main.path(forResource: "gramoSound", ofType: "mp3")
        self.effectPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: gramoSound!))
        
        scanSongs()
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch _ {
        }
    }
    
    deinit {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch _ {
        }
    }
    
    func getData(){
        if(self.musicIndex == -1) {return}
        self.title = self.musicList[self.musicIndex].title
        self.data = self.musicList[self.musicIndex].data
        self.author = self.musicList[self.musicIndex].author
        self.player = try! AVAudioPlayer(contentsOf: self.musicList[self.musicIndex].musicURL)
    }
    
    func scanSongs(){
        let fm = FileManager.default
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.musicList = []
        do {
            let items = try fm.contentsOfDirectory(at: path, includingPropertiesForKeys: .none)
            for itemURL in items {
                if(itemURL.absoluteString.hasSuffix(".mp3")){
                    let asset = AVAsset(url: itemURL)
                    var title = "Title"
                    var data:Data = .init(count: 0)
                    var author = "Artist"
                    for i in asset.commonMetadata{
                        if i.commonKey?.rawValue == "artwork"{
                            data = i.value as! Data
                        }
                        if i.commonKey?.rawValue == "title"{
                            title = i.value as! String
                        }
                        if i.commonKey?.rawValue == "artist"{
                            author = i.value as! String
                        }
                    }
                    self.musicList.append(eachSong(data: data, title: title, author: author, musicURL: itemURL))
                }
            }
        } catch {
            print("Fail read directory")
        }
    }
}



// struct for storing songs
struct eachSong{
    var data:Data = .init(count: 0)
    var title:String = "Title"
    var author:String = "Artist"
    var musicURL:URL
}


