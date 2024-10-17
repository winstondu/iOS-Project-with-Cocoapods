//
//  ImageItem.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 10/8/24.
//

// MARK: - MenuItem

import Foundation

struct ImageItem: Identifiable {
    var id: String { title }
    let title: String
    let url: URL
}
