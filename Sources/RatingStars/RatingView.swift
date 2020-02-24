//
//  RantingView.swift
//
//
//  Created by Chris Spradling on 2/23/20.
//

import Combine
import SwiftUI

public struct RatingView: View {
    
    private var icon: IconSet

    @Binding var rating: Int
    private let maxValue: Int

    public init(rating: Binding<Int>, maxRating: Int = 5, iconSet: IconSet = .stars) {
        self._rating = rating
        self.maxValue = maxRating
        self.icon = iconSet
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.iconStack
                .imageScale(.large)
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text("Rating"))
                .accessibility(value: self.description)
                .accessibilityAdjustableAction(self.stepRating)
                .highPriorityGesture(self.dragGesture(with: geometry))
        }
    }
    
    private var iconStack: some View {
        HStack {
            ForEach((1...maxValue), id: \.self, content: self.icon(for:))
        }
    }
    
    private func dragGesture(with geometry: GeometryProxy) -> some Gesture {
        DragGesture().onChanged {
            let newRating = self.rating(for: $0, with: geometry)
            self.setRating(newRating)
        }
    }
    
    func stepRating(_ direction: AccessibilityAdjustmentDirection) {
        switch direction {
        case .increment:
            setRating(rating + 1)
        case .decrement:
            setRating(rating - 1)
        @unknown default:
            return
        }
    }
    
    var description: Text {
        Text("\(rating) out of \(maxValue)")
    }
    
    private func icon(for index: Int) -> some View {
        Icon(icon, index: index, rating: $rating)
            .onTapGesture(perform: {
                if index == self.rating {
                    self.resetRating()
                } else {
                    self.setRating(index)
                }
            })
    }
    
    private func setRating(_ value: Int) {
        rating = min(max(0, value), maxValue)
    }
    
    private func resetRating() {
        rating = 0
    }
    
    private func rating(for position: DragGesture.Value, with geometry: GeometryProxy) -> Int {
        let unit: CGFloat = geometry.frame(in: .local).width / CGFloat(maxValue)
        return Int(ceil(position.location.x / unit)) + 1
    }
    
}
