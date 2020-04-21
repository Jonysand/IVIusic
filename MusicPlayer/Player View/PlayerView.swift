//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @State var PM = PlayerManager()
    @State var showPlayground:Bool = false
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                ZStack(alignment:.bottom){
                    VStack{
                        Text(self.PM.title)
                            .font(.title)
                            .padding()
                        ZStack{
                            // album cover
                            Rectangle()
                                .foregroundColor(.rgb(r: 251, g: 195, b: 126))
//                            Image(uiImage: (self.PM.data.count == 0 ? UIImage(systemName: "play.rectangle.fill"):UIImage(data: self.PM.data))!)
//                                .resizable()
                                
                            
                            GramoView(PM: self.$PM)
                        }.frame(height:geo.size.height/2)
                            .padding()
                        
                        // play button
                        PlayButtonView(PM: self.$PM)
                            .frame(height: 100)
                        
                        Spacer()
                    }
                    // playground view swipper
                    Image(systemName: "chevron.compact.up")
                        .resizable()
                        .foregroundColor(.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                        .padding()
                        .onTapGesture {
                            self.showPlayground.toggle()
                    }
                    .isHidden(self.showPlayground)
                }.frame(width: geo.size.width, height: geo.size.height)
                ZStack(alignment: .top){
                    PlaygroundView()
                    Image(systemName: "chevron.compact.down")
                        .resizable()
                        .foregroundColor(.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                        .padding()
                        .onTapGesture {
                            self.showPlayground.toggle()
                    }
                    .isHidden(!self.showPlayground)
                }.frame(width: geo.size.width, height: geo.size.height)
            }.offset(y: self.showPlayground ? -geo.size.width:geo.size.width)
                .animation(.linear)
                .onAppear{
                    self.PM.getData()
            }
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView()
//    }
//}
