//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Darren Beukes on 21/2/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
