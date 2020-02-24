//
//  Icon.swift
//  
//
//  Created by Chris Spradling on 2/23/20.
//

import Combine
import SwiftUI

struct Icon: View {
    
    @Binding private var rating: Int

    private var icon: IconSet
    private var index: Int
    
    init(_ icon: IconSet, index: Int, rating: Binding<Int>) {
        self.icon = icon
        self.index = index
        self._rating = rating
    }
    
    var isOn: Bool {
        rating >= index
    }
    
    var body: some View {
        icon.image(isOn: isOn)
    }
    
}
