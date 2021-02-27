//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Darren Beukes on 27/2/21.
//
import SwiftUI

struct OptionalImage: View {
  var image: UIImage?
  
  var body: some View {
    Group {
      if image != nil {
        Image(uiImage:image!)
      }
    }
  }
}
