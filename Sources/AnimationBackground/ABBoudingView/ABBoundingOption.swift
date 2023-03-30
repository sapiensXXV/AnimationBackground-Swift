//
//  ABBoundingOption.swift
//  
//
//  Created by Jaehoon So on 2023/03/31.
//

import Foundation

public struct ABBoundingConfiguration {
    let imageSize: CGFloat
    let rotationSpeed: CGFloat
    let velocity: CGFloat
    
    public init() {
        self.imageSize = 100
        self.rotationSpeed = 8
        self.velocity = 60
    }
}
