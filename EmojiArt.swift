//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Darren Beukes on 21/2/21.
//

import Foundation

struct EmojiArt {
  var backgroundURL: URL?
  var emojis = [Emoji]()
  
  struct Emoji: Identifiable {
    let text: String
    var x: Int
    var y: Int
    var size: Int
    let id: Int
    
    fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
      self.text = text
      self.x = x  // offset from center
      self.y = y  // offset from center
      self.size = size
      self.id = id
    }
  }
  
  private var uniuqeEmojiId = 0
  
  mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
    emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniuqeEmojiId))
    uniuqeEmojiId += 1
  }
}

