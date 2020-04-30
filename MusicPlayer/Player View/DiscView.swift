//
//  DiscView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/23/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct DiscView: View {
    @EnvironmentObject var PM:PlayerManager
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                // default cover
                Circle()
                    .foregroundColor(.rgb(r: 251, g: 195, b: 126))
                    .isHidden(self.PM.data.count != 0)
                // cover image
                Image(uiImage: (self.PM.data.count == 0 ? UIImage(systemName: "play.rectangle.fill"):UIImage(data: self.PM.data))!)
                    .resizable()
                    .clipShape(Circle())
                    .isHidden(self.PM.data.count == 0)
            }.overlay(Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(Color.init("LBcolor"))
                .blur(radius: 5))
//                .frame(width: geo.size.width - 25, height: geo.size.width - 25)
        }
    }
}

struct DiscView_Previews: PreviewProvider {
    static var previews: some View {
        DiscView()
    }
}
