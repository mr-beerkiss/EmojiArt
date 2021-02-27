//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Darren Beukes on 21/2/21.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
  static let palette: String = "⭐️🌧🍎🌎🥨⚾️"
  
  @Published private var emojiArt: EmojiArt {
    didSet {
      UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitledDocumentKey )
    }
    /*
     // In the lecture demo, he states that `didSet` and `@Published` do not work well together
     // and at the time it was known issue. It appears to have been fixed, but I've included
     // the workaround here for interest sake. You call the `send() function on the special field
     // `objectWillChange` available inside `willSet`. You also need to remove the `@Published`
     // property wrapper
     willSet {
      objectWillChange.send()
     }
     */
  }
  
  private static let untitledDocumentKey = "EmojiArtDocument.Untitled"
  
  init() {
    emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitledDocumentKey)) ?? EmojiArt()
    fetchBackgroundImageData()
  }
  
  @Published private(set) var backgroundImage: UIImage?
  
  var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
  
  // MARK: Intents
  func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
    emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
  }
  
  func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
    if let index = emojiArt.emojis.firstIndex(matching: emoji) {
      emojiArt.emojis[index].x += Int(offset.width)
      emojiArt.emojis[index].y += Int(offset.height)
    }
  }
  
  func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
    if let index = emojiArt.emojis.firstIndex(matching: emoji) {
      emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
    }
  }
  
  func setBackgroundURL(_ url: URL?) {
    emojiArt.backgroundURL = url?.imageURL
    fetchBackgroundImageData()
  }
  
  private func fetchBackgroundImageData() {
    backgroundImage = nil
    if let url = self.emojiArt.backgroundURL {
      DispatchQueue.global(qos: .userInitiated).async {
        if let imageData = try? Data(contentsOf: url) {
          DispatchQueue.main.async {
            if url == self.emojiArt.backgroundURL {
              self.backgroundImage = UIImage(data: imageData)
            }
          }
        }
      }
    }
  }
}

extension EmojiArt.Emoji {
  var fontSize: CGFloat { CGFloat(self.size) }
  var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
