//
//  ABCheckBoardView.swift
//  AnimationBackground-Swift
//
//  Created by Jaehoon So on 2023/02/19.
//

import UIKit

@available(iOS 13.0, *)
public final class ABCheckBoardView: UIView {

    enum Metric: Int {
        case minimumDivideValue = 8
        case maximumDivideValue = 6
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var mainImage: UIImage = UIImage(systemName: "photo")!
    private var coordinates: [[(x: CGFloat, y: CGFloat)]] = []
    private var imageViews: [UIImageView] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

@available(iOS 13.0, *)
extension ABCheckBoardView {
        
    public func configureImage(image: UIImage) {
        self.mainImage = image
    }
    
    public func activate() {
        print(#function)
        let width = self.bounds.width
        let height = self.bounds.height
        let maximumSize = width / CGFloat(Metric.maximumDivideValue.rawValue)
        let minimumSize = width / CGFloat(Metric.minimumDivideValue.rawValue)
        
        
        createCoordinates(width: width, height: height)
        addImageViews(width: width, height: height)
        
        let dividedTime = 1 / Double(self.coordinates.count)
        
        for (index, imageView) in imageViews.enumerated() {
            UIView.animate(
                withDuration: 1,
                delay: dividedTime * Double(index),
                options: [.repeat, .autoreverse]) {
                    imageView.bounds.size.width += (maximumSize - minimumSize)
                    imageView.bounds.size.height += (maximumSize - minimumSize)
                }
        }
        
    }
    
    public func createCoordinates(width: CGFloat, height: CGFloat) {
        print(#function)
        let viewSize = width / CGFloat(Metric.maximumDivideValue.rawValue)
        let numberOfHeightBlock = Int(height / viewSize + 1)
        
        createCoordinatesArray(count: numberOfHeightBlock)
        
        (0..<self.coordinates.count).forEach { index in
            (0..<Metric.maximumDivideValue.rawValue).forEach { count in
                if isEven(number: index) && isEven(number: count) {
                    self.coordinates[index].append(
                        (x: viewSize * CGFloat(count), y: viewSize * CGFloat(index)
                        )
                    )
                } else if !isEven(number: index) && !isEven(number: count) {
                    self.coordinates[index].append(
                        (x: viewSize * CGFloat(count), y: viewSize * CGFloat(index))
                    )
                }
            }
        }
    }
    
    public func addImageViews(width: CGFloat, height: CGFloat) {
        let _ = width / CGFloat(Metric.minimumDivideValue.rawValue)
        let maximumSize = width / CGFloat(Metric.maximumDivideValue.rawValue)
    
        coordinates.forEach { row in
            row.forEach { (x, y) in
                let imageView = UIImageView(image: self.mainImage)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.layer.opacity = 0.5
                self.addSubview(imageView)
                self.imageViews.append(imageView)
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: x),
                    imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: y),
                    imageView.widthAnchor.constraint(equalToConstant: maximumSize),
                    imageView.heightAnchor.constraint(equalToConstant: maximumSize),
                ])
            }
        }
    }
    
    public func createCoordinatesArray(count: Int) {
        (0..<count).forEach { _ in
            self.coordinates.append([])
        }
    }
    
    public func isEven(number: Int) -> Bool {
        return number % 2 == 0
    }
    
}

