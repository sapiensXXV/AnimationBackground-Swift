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
    
    public init(
        imageSize: CGFloat = 100,
        rotationSpeed: CGFloat = 8,
        velocity: CGFloat = 60
    ) {
        self.imageSize = imageSize
        self.rotationSpeed = rotationSpeed
        self.velocity = velocity
    }
}
