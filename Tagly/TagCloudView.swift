//
//  TagCloudView.swift
//  Tagly
//
//  Created by Alan Paiva on 8/7/20.
//

import SwiftUI

/// A view that allows displaying content in tag cloud manner.
public struct TagCloudView<T, Content>: View where T: Identifiable, Content: View {
    /// Holds the rendering height and coordinates of a TagCloudView.
    /// It's a dynamic frame though, which means its values change while
    /// the TagCloudView is being rendered.
    private class Frame: ObservableObject {
        /// Horizontal offset that determines where to draw the next tag in the x axis.
        var x: CGFloat = 0

        /// Vertical offset that determines where to draw the next tag in the y axis.
        var y: CGFloat = 0

        /// The current height of a TagCloudView.
        @Published var height: CGFloat = 0
    }

    /// Data to be iterated and displayed.
    let data: [T]

    /// Spacing between each tag in the cloud.
    let spacing: CGFloat

    /// Closure that builds each tag in the cloud.
    let content: (T) -> Content

    /// Holds the rendering state of the cloud view. Used to determine
    /// the vertical and horizonatal offsets to draw each tag and to clip the
    /// cloud itself at the minimum necessary height.
    @ObservedObject private var frame = Frame()

    /// Builds a TagCloudView.
    ///
    /// - Parameters:
    ///   - data: The data to be iterated and displayed.
    ///   - spacing: The spacing between each tag in the cloud.
    ///   - content: ViewBuilder Closure that builds each tag in the cloud.
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

    /// Builds a new tag in the cloud by providing the proper x and y offsets based on the geometry
    ///
    /// - Parameters:
    ///   - element: The identifiable element to display.
    ///   - geometry: The geometry of the parent view.
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
                // the new tag doesn't fit the available space
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

