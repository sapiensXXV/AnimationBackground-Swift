//
//  ABRainingView.swift
//  AnimationBackground
//
//  Created by Jaehoon So on 2023/02/15.
//

import UIKit

/// This class inherits from the UIView to show the rain effect.
/// You can register images with the `configureImages(images:)` method and activate the animation
/// with the `activate()` method.
public final class ABRainingView: UIView, VerticalAnimationProtocol {
    
    private var imageViews: [UIImageView] = []
    private var imageOpacity: Float = 1.0
    private var numberOfImage: Int {
        return images.count
    }
    
    public var images: [UIImage] = []
    public var maximumImageCount: Int = 40
    public var animationSpeed: AnimationSpeed = .normal
    
    public convenience init(opacity: Float) {
        self.init(frame: CGRect())
        self.imageOpacity = opacity
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - Functions
extension ABRainingView {
    
    /// activate animations
    public func activate() {
        
        // 처음에는 10개 정도의 이미지를 등록해보자
        for count in 0..<maximumImageCount {
            let image = images[count % numberOfImage]
            let imageView: UIImageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.opacity = 1.0
            self.imageViews.append(imageView)
            
            addSubview(imageView)
        }
        
        for (index, imageView) in imageViews.enumerated() {
            let viewWidth = self.bounds.width
            let viewHeight = self.bounds.height
            let randomXCoordinate = Double.random(in: 0..<1) * viewWidth

            NSLayoutConstraint.activate([
                imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: viewWidth / 10),
                imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: randomXCoordinate),
                imageView.widthAnchor.constraint(equalToConstant: viewWidth / 10),
                imageView.heightAnchor.constraint(equalToConstant: viewWidth / 10),
            ])
            
            UIView.animate(
                withDuration: Double(self.animationSpeed.rawValue),
                delay: (1.5 / Double(self.maximumImageCount)) * Double(index),
                options: [.repeat, .curveEaseIn]
            ) {
                imageView.frame.origin.y += self.bounds.height + viewWidth / 10
            }
        }
    }
}
