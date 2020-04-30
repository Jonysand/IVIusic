//
//  testView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/28/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI
import AVKit

struct testView: View {
    @EnvironmentObject var PM:PlayerManager
    let fm = FileManager.default
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    var body: some View {
        Button(action: {
            do {
                let items = try self.fm.contentsOfDirectory(at: self.path, includingPropertiesForKeys: .none)
                for itemURL in items {
                    if(itemURL.absoluteString.hasSuffix(".mp3")){
                        let asset = AVAsset(url: itemURL)
                        for i in asset.commonMetadata{
                            print(i.commonKey?.rawValue as Any)
                        }
                    }
                }
            } catch {
                print("Fail read directory")
            }
        }){
            Text("Test")
        }
    }
}
