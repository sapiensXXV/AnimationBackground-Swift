//
//  VerticalAnimationProtocol.swift
//  
//
//  Created by Jaehoon So on 2023/03/15.
//

import UIKit

/// A protocol vertical animated views. Like ABRainingView, ABRisingView
public protocol VerticalAnimationProtocol: AnyObject {
    var images: [UIImage] { get set }
    var maximumImageCount: Int { get set }
    var animationSpeed: AnimationSpeed { get set }
    
    func configureImages(images: [UIImage])
    func configureImageNumber(to count: Int)
    func configureSpeed(to speed: AnimationSpeed)
    func activate()
}

extension VerticalAnimationProtocol {
    
    public func configureImages(images: [UIImage]) {
        self.images = images
    }
    
    public func configureImageNumber(to count: Int) {
        self.maximumImageCount = count
    }
    
    public func configureSpeed(to speed: AnimationSpeed) {
        self.animationSpeed = speed
    }
}
