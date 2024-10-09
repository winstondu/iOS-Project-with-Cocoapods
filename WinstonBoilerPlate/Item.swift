//
//  MenuItem.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 10/8/24.
//  Copyright © 2024 Dougly. All rights reserved.
//

// MARK - MenuItem

import Foundation

struct Item: Identifiable {
    var id: String { title }
    let title: String
    let url: URL
}

