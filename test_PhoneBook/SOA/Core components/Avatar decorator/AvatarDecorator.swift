//
//  File.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

struct AvatarDecorator: AvatarDecoratorProtocol {
  
  fileprivate let colors: [UIColor] = [
    UIColor.hexColor(rgb:0xffe57373),
    UIColor.hexColor(rgb:0xfff06292),
    UIColor.hexColor(rgb:0xffba68c8),
    UIColor.hexColor(rgb:0xff9575cd),
    UIColor.hexColor(rgb:0xff7986cb),
    UIColor.hexColor(rgb:0xff64b5f6),
    UIColor.hexColor(rgb:0xff4fc3f7),
    UIColor.hexColor(rgb:0xff4dd0e1),
    UIColor.hexColor(rgb:0xff4db6ac),
    UIColor.hexColor(rgb:0xff81c784),
    UIColor.hexColor(rgb:0xffaed581),
    UIColor.hexColor(rgb:0xffff8a65),
    UIColor.hexColor(rgb:0xffd4e157),
    UIColor.hexColor(rgb:0xffffd54f),
    UIColor.hexColor(rgb:0xffffb74d),
    UIColor.hexColor(rgb:0xffa1887f),
    UIColor.hexColor(rgb:0xff90a4ae)
  ]
  
  
  func saveAvatar(uuid: String, name: String) {
    let initials = getInitials(name: name)
    let avatar = generateAvatar(initials: initials)
    MediaCache.shared.save(key: uuid, image: avatar)
  }
  
  func loadAvatar(uuid: String) -> UIImage? {
    return MediaCache.shared.load(key:uuid)
  }
  
  
  fileprivate func generateAvatar(initials: String) -> UIImage {
    let rendererFormat = UIGraphicsImageRendererFormat()
    rendererFormat.opaque = false
    let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
    let random = Int(arc4random_uniform(17))
    let randomColor = colors[random]
    let fontSize: CGFloat = initials.count > 1 ? 20.0 : 30.0
    let fontYOffset: CGFloat = initials.count > 1 ? 13.0 : 7.0
    let fontXOffset: CGFloat = initials.count > 1 ? 0.0 : 1.0
    let renderer = UIGraphicsImageRenderer(size: rect.size, format: rendererFormat)
    let snapshotImage = renderer.image { rendererContext in
      rendererContext.cgContext.setFillColor(randomColor.cgColor)
      rendererContext.cgContext.setStrokeColor(UIColor.clear.cgColor)
      rendererContext.cgContext.addRect(rect)
      rendererContext.cgContext.drawPath(using: .fillStroke)
      rendererContext.cgContext.setShouldSmoothFonts(false)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      let attrs = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: fontSize)!, NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.foregroundColor: UIColor.white]
      initials.draw(with: CGRect(x: fontXOffset, y: fontYOffset, width: 50, height: 50), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
    return snapshotImage
  }
  
  fileprivate func getInitials(name: String) -> String {
    var initialsFinal = ""
    let initials = name.components(separatedBy: " ")
    if initials.count > 1 {
      var count = 0
      for initial in initials {
        guard count < 2 else { return initialsFinal }
        guard !initial.isEmpty else { continue }
        let filtered = initial.components(separatedBy: CharacterSet.letters.inverted).joined(separator: "")
        guard let letter = filtered.uppercased().first else { continue }
        initialsFinal += "\(letter)"
        count += 1
      }
    } else {
      if let first = initials[0].uppercased().first {
        initialsFinal = "\(first)"
      }
    }
    return initialsFinal
  }
  
}


