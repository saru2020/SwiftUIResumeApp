//
//  CustomFonts.swift
//  MyResumeApp
//
//  Created by Saravanan on 17/11/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import UIKit

let iconfont = "icomoon"

public enum FontIcon: UInt32 {
  case skills = 0xe995
  case star_empty = 0xe9d7
  case star = 0xe9d9
  case mobile = 0xe958
  case aboutMe = 0xe976
  case company = 0xe9ae
  case email = 0xea86
    case blog = 0xeab8
    case github = 0xeab0
  case education = 0xe900
}

public final class IconFont {
    private class func iconFont(_ size: CGFloat) -> UIFont? {
        if size == 0.0 {
            return nil
        }
        loadMyCustomFont(iconfont)
        return UIFont(name: iconfont, size: size)
    }
    
    private class func loadMyCustomFont(_ name:String) {
        guard let fontPath = Bundle(for: IconFont.self).path(forResource: name, ofType: "ttf") else {
            return
        }
        
        var error: Unmanaged<CFError>?
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: fontPath)) , let provider = CGDataProvider(data: data as CFData) else {
            return
        }
        
        if let font = CGFont(provider) {
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
        if error != nil {
            return
        }
    }
}

extension IconFont {
  //loading font as shown in example above
  
  private class func stringForIcon(_ icon : FontIcon) -> String? {
        
        var rawIcon = icon.rawValue;
        let xPtr = withUnsafeMutablePointer(to: &rawIcon, { $0 })
        return String(bytesNoCopy: xPtr, length:MemoryLayout<UInt32>.size, encoding: String.Encoding.utf32LittleEndian, freeWhenDone: false)
    }
}

extension IconFont {
  //loading font here ...
      public class func string(fromIcon icon: FontIcon, size: CGFloat = CGFloat(12), color: UIColor?) -> NSAttributedString? {
        
        guard let font = IconFont.iconFont(size) , let string = stringForIcon(icon) else {
            return nil
        }
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.font] = font
        
        if let color = color {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    public class func image(fromIcon icon: FontIcon, size: CGFloat, color: UIColor?) -> UIImage? {
        
        if size == 0.0 {
            return nil
        }
        
        guard let symbol = string(fromIcon: icon, size: size, color: color) else {
            return nil
        }
        
        let mutableSymbol = NSMutableAttributedString(attributedString: symbol)
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
            mutableSymbol.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, mutableSymbol.length))
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        mutableSymbol.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
