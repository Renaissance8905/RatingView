//
//  IconSet.swift
//
//
//  Created by Chris Spradling on 2/23/20.
//

import SwiftUI

public enum IconSet {
    case stars
    case hearts
    case circles
    case custom(on: Image, off: Image)
    
    func image(isOn: Bool) -> Image {
        isOn ? onImage : offImage
        
    }

    private var onImage: Image {
        switch self {
        case .stars:                return Image(systemName: "star.fill")
        case .hearts:               return Image(systemName: "heart.fill")
        case .circles:              return Image(systemName: "circle.fill")
        case .custom(let img, _):   return img
        }
        
    }
    
    private var offImage: Image {
        switch self {
        case .stars:                return Image(systemName: "star")
        case .hearts:               return Image(systemName: "heart")
        case .circles:              return Image(systemName: "circle")
        case .custom(_, let img):   return img
        }
        
    }
    
}
