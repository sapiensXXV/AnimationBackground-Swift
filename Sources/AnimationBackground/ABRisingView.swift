//
//  ABRisingView.swift
//  AnimationBackground
//
//  Created by Jaehoon So on 2023/02/15.
//

import UIKit

public final class ABRisingView: UIView {

    private var images: [UIImage] = []
    private var imageViews: [UIImageView] = []
    private var imageOpacity: Float = 1.0
    private var numberOfImage: Int {
        return images.count
    }
    
    private var maximumImageCount = 40
    
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

extension ABRisingView {
    
    public func activate() {
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
                imageView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -(viewWidth / 10)),
                imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: randomXCoordinate),
                imageView.widthAnchor.constraint(equalToConstant: viewWidth / 10),
                imageView.heightAnchor.constraint(equalToConstant: viewWidth / 10),
            ])
            
            UIView.animate(
                withDuration: 1.5,
                delay: (1.5 / Double(maximumImageCount)) * Double(index),
                options: [.repeat, .curveEaseIn]
            ) {
                imageView.frame.origin.y -= viewHeight + 2 * (viewWidth / 10)
            }
        }
    }
    
    public func configureImages(images: [UIImage]) {
        self.images = images
    }
    
}
