//
//  testView.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/28/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct testView: View {
    
    var body: some View {
        ForEach(0..<20, id:\.self){row in
            VStack{
                HStack{
                    ForEach(0..<10, id:\.self){col in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
        }
    }
}
