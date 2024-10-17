//
import Nuke
import NukeUI
//  ImageDemoView.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 10/8/24.
//
import SwiftUI

@MainActor
struct ImageDemoView: View {
    @State private var listId = UUID()
    @ObservedObject var imageList: ImageList

    private let pipeline = ImagePipeline {
        $0.dataLoader = {
            let config = URLSessionConfiguration.default
            config.urlCache = nil
            return DataLoader(configuration: config)
        }()
    }

    var body: some View {
        List(imageList.images) { item in
            let view = VStack(spacing: 16) {
                Text(item.title)
                    .font(.headline)
                    .padding(.top, 32)
                makeImage(url: item.url).onTapGesture {
                    imageList.images.removeLast()
                }
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

#Preview {
    ImageDemoView(imageList: ImageList())
}
