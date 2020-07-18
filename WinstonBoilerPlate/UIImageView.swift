//
//  UIImageView.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 7/17/20.
//  Copyright © 2020 Winston. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    override open func layoutSubviews() {
        print("Layout subviews called") // THESE DO NOT GET PRINTED on debug!
        super.layoutSubviews()
    }
    
    override open func layoutIfNeeded() {
        print("LayoutIfNeeded called") // THESE DO NOT GET PRINTED on debug!
        super.layoutIfNeeded()
    }
}
