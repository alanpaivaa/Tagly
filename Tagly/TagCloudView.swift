//
//  TagCloudView.swift
//  Tagly
//
//  Created by Alan Paiva on 8/7/20.
//

import SwiftUI

public struct TagCloudView<T, Content>: View where T: Identifiable, Content: View {
    private class Frame: ObservableObject {
        var x: CGFloat = 0
        var y: CGFloat = 0
        @Published var height: CGFloat = 0
    }

    let data: [T]
    let spacing: CGFloat
    let content: (T) -> Content

    @ObservedObject private var frame = Frame()

    public init(data: [T], spacing: CGFloat = 0, @ViewBuilder content: @escaping (T) -> Content) {
        self.data = data
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.data) { element in
                    self.makeTagView(element: element, geometry: geometry)
                }
            }
        }
        .frame(height: frame.height)
    }

    private func makeTagView(element: T, geometry: GeometryProxy) -> some View {
        content(element)
            .alignmentGuide(.leading) { d in
                let isFirst = element.id == self.data.first?.id
                if isFirst {
                    self.frame.y = 0
                }

                let availableWidth = geometry.size.width
                let exceedsAvailableWidth = (self.frame.x + d.width) > availableWidth

                if isFirst {
                    if self.frame.height == 0 {
                        self.frame.height = d.height
                    }
                } else if exceedsAvailableWidth {
                    self.frame.y += d.height + self.spacing
                    let newHeight = self.frame.y + d.height
                    if newHeight > self.frame.height {
                        self.frame.height = newHeight
                    }
                }

                // Should restore to leading if it's the first tag or
                // the new tag doesn't fit available space
                if isFirst || exceedsAvailableWidth {
                    self.frame.x = d.width + self.spacing
                    return 0
                }

                defer {
                    self.frame.x += (d.width + self.spacing)
                }
                return -self.frame.x
            }
            .alignmentGuide(.top) { _ in
                return -self.frame.y
            }
    }
}


struct TagCloudView_Previews: PreviewProvider {
    private struct TagModel: Identifiable, Equatable {
        let id = UUID()
        let name: String

        static func == (lhs: TagModel, rhs: TagModel) -> Bool {
            lhs.id == rhs.id
        }
    }

    private static var tags: [TagModel] {
        [
            TagModel(name: "A"),
            TagModel(name: "Lorem Ipsum"),
            TagModel(name: "Cool books"),
            TagModel(name: "Thriller"),
            TagModel(name: "Fantasy"),
            TagModel(name: "Cool Best sellers"),
            TagModel(name: "Help"),
            TagModel(name: "Some really cool tag")
        ]
    }

    static var previews: some View {
        TagCloudView(data: tags, spacing: 10) { tag in
            Text(tag.name)
                .padding(.vertical, 5)
                .padding(.horizontal, 12)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
        .padding(10)
    }
}

