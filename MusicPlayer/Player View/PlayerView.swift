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
    @EnvironmentObject var PM:PlayerManager
    @State var showPlayground:Bool = false
    @State var stylusPos:CGPoint = .zero
    
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
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.rgb(r: 251, g: 195, b: 126))
                                    .isHidden(self.PM.data.count != 0)
                                Image(uiImage: (self.PM.data.count == 0 ? UIImage(systemName: "play.rectangle.fill"):UIImage(data: self.PM.data))!)
                                    .resizable()
                                    .isHidden(self.PM.data.count == 0)
                            }.frame(width: geo.size.width - 25, height: geo.size.width - 25)
                            
                            GramoView(stylusPos: self.$stylusPos)
                        }.frame(height:geo.size.height/2)
                            .padding()
                        
                        // play button
                        PlayButtonView(stylusPos: self.$stylusPos)
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
                        .gesture(DragGesture()
                            .onEnded{value in
                                if value.translation.height < 0 {self.showPlayground.toggle()}
                            }
                        )
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
                        .gesture(DragGesture()
                            .onEnded{value in
                                if value.translation.height > 0 {self.showPlayground.toggle()}
                            }
                        )
                        .isHidden(!self.showPlayground)
                }.frame(width: geo.size.width, height: geo.size.height)
            }.offset(y: self.showPlayground ? -geo.size.width : geo.size.width)
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
