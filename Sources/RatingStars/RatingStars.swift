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
            .highPriorityGesture(
                DragGesture()
                    .onChanged({ value in
                        let targetRating = self.rating(for: value, with: geometry)
                        self.updateRating(targetRating)
                    })
            )
        }
    }
    
    private var iconStack: some View {
        HStack {
            ForEach((1...maxValue), id: \.self, content: self.icon(for:))
        }
    }
    
    private func icon(for index: Int) -> some View {
        icon.image(isOn: rating >= index)
            .onTapGesture(perform: { self.updateRating(index) })
    }
    
    private func updateRating(_ value: Int) {
        rating = min(max(0, value), maxValue)
    }
    
    private func rating(for position: DragGesture.Value, with geometry: GeometryProxy) -> Int {
        let unit: CGFloat = geometry.frame(in: .local).width / CGFloat(maxValue)
        return Int(ceil(position.location.x / unit)) + 1
    }
    
}
