//
//  ImageList.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 10/17/24.
//  Copyright © 2024 Dougly. All rights reserved.
//
import Combine
import Foundation

class ImageList: ObservableObject {
    @Published var images: [ImageItem] = allItems
}

private let allItems = [
    ImageItem(title: "Baseline JPEG", url: URL(string: "https://user-images.githubusercontent.com/1567433/120257591-80e2e580-c25e-11eb-8032-54f3a966aedb.jpeg")!),
    ImageItem(title: "Progressive JPEG", url: URL(string: "https://user-images.githubusercontent.com/1567433/120257587-7fb1b880-c25e-11eb-93d1-7e7df2b9f5ca.jpeg")!),
    ImageItem(title: "WebP", url: URL(string: "https://kean.github.io/images/misc/4.webp")!),
]
