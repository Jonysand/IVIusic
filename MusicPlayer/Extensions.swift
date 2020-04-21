//
//  Extensions.swift
//  MusicPlayer
//
//  Created by Yongkun Li on 4/19/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

extension View {
    /// Hide or show the view based on a boolean value.
    ///  > https://stackoverflow.com/questions/56490250/dynamically-hiding-view-in-swiftui/56490886
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
}
fileprivate struct HiddenModifier: ViewModifier {
    
    private let isHidden: Bool
    private let remove: Bool
    
    init(isHidden: Bool, remove: Bool = false) {
        self.isHidden = isHidden
        self.remove = remove
    }
    
    func body(content: Content) -> some View {
        Group {
            if isHidden {
                if remove {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}

extension Color{
    static func rgb(r:Double, g:Double, b: Double) -> Color{
        return Color(red:r/255, green:g/255, blue:b/255)
    }
}
