//
//  ContentView.swift
//  TaglyExamples
//
//  Created by Alan Paiva on 8/7/20.
//

import SwiftUI
import Tagly

struct ContentView: View {
    private let tags = [
        Tag(id: 1, title: "Blues"),
        Tag(id: 2, title: "Rock"),
        Tag(id: 3, title: "Heavy Metal"),
        Tag(id: 4, title: "Alternative Country"),
        Tag(id: 5, title: "Contemporary Metal"),
        Tag(id: 6, title: "Electroacoustic"),
        Tag(id: 7, title: "British Folk Revival"),
        Tag(id: 8, title: "Electronic"),
        Tag(id: 9, title: "Indie"),
        Tag(id: 10, title: "Classic"),
        Tag(id: 11, title: "Punk"),
    ]

    var body: some View {
        TagCloudView(data: tags, spacing: 8) { tag in
            Text(tag.title)
                .foregroundColor(Color.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.black)
                .cornerRadius(5)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
