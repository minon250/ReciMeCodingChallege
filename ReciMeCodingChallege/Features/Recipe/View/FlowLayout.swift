//
//  RoundedTextView.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 22/1/2023.
//

import SwiftUI

struct FlowLayout<RowContent: View>: View {
    // State variable to store the height of the view
    @State private var height: CGFloat = .zero

    // Data source for the layout
    private var data: [String]
    // Spacing between elements
    private var spacing: CGFloat
    // Closure to create the content for each row
    private var rowContent: (String) -> RowContent

    /**
     Initializer for FlowLayout

     - Parameters:
        - data: An array of Strings to be used as the data source
        - spacing: The amount of space to be placed between elements (defaults to 4)
        - rowContent: A closure that creates the content for each row, based on the string provided
    */
    public init(_ data: [String], spacing: CGFloat = 4, @ViewBuilder rowContent: @escaping (String) -> RowContent) {
        self.data = data
        self.spacing = spacing
        self.rowContent = rowContent
    }

    var body: some View {
        GeometryReader { geometry in
            content(in: geometry)
                .background(viewHeight(for: $height))
        }
        .frame(height: height)
    }

    /**
     Creates the content for the layout

     - Parameters:
        - geometry: The geometry proxy used to determine the size of the view

     - Returns: A view containing the rows of content
    */
    private func content(in geometry: GeometryProxy) -> some View {
        var bounds = CGSize.zero

        return ZStack {
            ForEach(data, id: \.self) { item in
                rowContent(item)
                    .padding(.all, spacing)
                    .alignmentGuide(VerticalAlignment.center) { dimension in
                        let result = bounds.height

                        if let firstItem = data.first, item == firstItem {
                            bounds.height = 0
                        }
                        return result
                    }
                    .alignmentGuide(HorizontalAlignment.center) { dimension in
                        if abs(bounds.width - dimension.width) > geometry.size.width {
                            bounds.width = 0
                            bounds.height -= dimension.height
                        }

                        let result = bounds.width

                        if let firstItem = data.first, item == firstItem {
                            bounds.width = 0
                        } else {
                            bounds.width -= dimension.width
                        }
                        return result
                    }
            }
        }
    }

    /**
     Creates a view that updates the height binding when the layout's size changes

     - Parameters:
        - binding: The binding to update with the new height

     - Returns: A view that updates the binding when its size changes
    */
    private func viewHeight(for binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)

            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
