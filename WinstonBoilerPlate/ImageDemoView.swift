//
import Nuke
import NukeUI
//  ContentView.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 10/8/24.
//  Copyright © 2024 Dougly. All rights reserved.
//
import SwiftUI

@MainActor
struct ImageDemoView: View {
    private let items = allItems
    @State private var listId = UUID()

    private let pipeline = ImagePipeline {
        $0.dataLoader = {
            let config = URLSessionConfiguration.default
            config.urlCache = nil
            return DataLoader(configuration: config)
        }()
    }

    var body: some View {
        List(items) { item in
            let view = VStack(spacing: 16) {
                Text(item.title)
                    .font(.headline)
                    .padding(.top, 32)
                makeImage(url: item.url)
            }.listRowInsets(EdgeInsets())
            if #available(iOS 15, *) {
                view.listRowSeparator(.hidden)
            } else {
                view
            }
        }
        .id(listId)
        .navigationBarItems(trailing: Button(action: {
            ImagePipeline.shared.cache.removeAll()
            self.listId = UUID()
            }, label: {
                Image(systemName: "arrow.clockwise")
        }))
        .listStyle(.plain)
    }

    // This is where the image view is created.
    func makeImage(url: URL) -> some View {
        LazyImage(source: url) { state in
            if let swiftUIImage = state.swiftUIImage {
                swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray.opacity(0.2) // Placeholder
            }
        }
        .pipeline(pipeline)
        .frame(height: 320)
    }
}

extension LazyImageState {
    /// Returns an image view.
    public var swiftUIImage: SwiftUI.Image? {
        #if os(macOS)
            imageContainer.map { Image(nsImage: $0.image) }
        #else
            imageContainer.map { Image(uiImage: $0.image) }
        #endif
    }
}

private let allItems = [
    Item(title: "Baseline JPEG", url: URL(string: "https://user-images.githubusercontent.com/1567433/120257591-80e2e580-c25e-11eb-8032-54f3a966aedb.jpeg")!),
    Item(title: "Progressive JPEG", url: URL(string: "https://user-images.githubusercontent.com/1567433/120257587-7fb1b880-c25e-11eb-93d1-7e7df2b9f5ca.jpeg")!),
    Item(title: "WebP", url: URL(string: "https://kean.github.io/images/misc/4.webp")!),
]


#Preview {
    ImageDemoView()
}
