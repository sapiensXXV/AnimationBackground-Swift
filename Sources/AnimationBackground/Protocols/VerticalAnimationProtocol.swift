//
//  File.swift
//  
//
//  Created by Jaehoon So on 2023/03/15.
//

import Foundation

/// A protocol vertical animated views. Like ABRainingView, ABRisingView
protocol VerticalAnimationProtocol: AnyObject {
    var maximumImageCount: Int { get set }
    var animationSpeed: AnimationSpeed { get set }
    
    func configureImageNumber(to count: Int)
    func configureSpeed(to speed: AnimationSpeed)
}

extension VerticalAnimationProtocol {
    func configureImageNumber(to count: Int) {
        self.maximumImageCount = count
    }
    
    func configureSpeed(to speed: AnimationSpeed) {
        self.animationSpeed = speed
    }
}
