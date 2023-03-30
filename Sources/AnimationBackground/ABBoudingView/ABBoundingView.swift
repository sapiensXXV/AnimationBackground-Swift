//
//  ABBoundingView.swift
//  AnimationBackground-Swift
//
//  Created by Jaehoon So on 2023/03/30.
//

import UIKit

final public class ABBoundingView: UIView {

    private var images: [UIImage] = []
    private var imageViews: [UIImageView] = []
    private var option: ABBoundingConfiguration = ABBoundingConfiguration()
    
    public init(
        images: [UIImage?],
        option: ABBoundingConfiguration = ABBoundingConfiguration()
    ) {
        self.images = images.compactMap{ $0 }
        self.option = option
        
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        self.clipsToBounds = true
        addImageViews()
        rotateView()
        animateView()
    }
    
    func makeRandomCoordinate() -> CGPoint {
        let randomX = Double.random(in: 0..<self.bounds.width)
        let randomY = Double.random(in: 0..<self.bounds.height)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    private func addImageViews() {
        
        for image in images {
            let randomCoordinate = makeRandomCoordinate()
            let newImageView = UIImageView(frame: CGRect(origin: randomCoordinate, size: CGSize(width: option.imageSize, height: option.imageSize)))
            newImageView.image = image
            
            newImageView.contentMode = .scaleAspectFit
            newImageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(newImageView)
            imageViews.append(newImageView)
        }
    }
    
    private func rotateView() {
        
        for imageView in imageViews {
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = Double.pi * 2 * [1, -1].randomElement()!// 2pi
            rotation.duration = option.rotationSpeed
            rotation.repeatCount = Float.infinity
            imageView.layer.add(rotation, forKey: "rotationAnimation")
        }
    }
    
    /// 전체 뷰를 애니메이션을 시작하는 메서드
    private func animateView() {
        for imageView in imageViews {
            let direction = makeDirection()
            moveView(with: imageView, direction: direction)
        }
    }
    
    /// 뷰 하나를 움직이는 메서드이다. completion handler를 통해 반복적으로 호출된다.
    private func moveView(with view: UIView, direction: ProgressDirection) {
        
        let collideInfo = makeCollideInfo(current: view.center, direction: direction)
        let collideDirection = collideInfo.direction
        let nextPoint = collideInfo.nextPoint
        let nextFrame = CGRect(origin: nextPoint, size: CGSize(width: option.imageSize, height: option.imageSize))
        let duration = makeDurationTime(current: view.center, next: nextPoint)
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear]) { [weak self] in
                view.center = nextPoint
            } completion: { [weak self] finished in
                let newDirection = self?.makeNextDirection(current: direction, collide: collideDirection)
                self?.moveView(with: view, direction: newDirection!)
            }
    }
    
    private func makeCollideInfo(current: CGPoint, direction: ProgressDirection) -> CollideInfo {
        
        /// current는 현재 다루고자 하는 뷰의 중심 좌표이다.
        /// ProgressDirection에 따라 y = x, y = -x 둘 중 하나의 함수를 정하고 다음에 충돌할 좌표를 반환한다.
        let height = self.frame.height
        let width = self.frame.width
        let x = current.x
        let y = height - current.y
        
        switch direction {
        case .topRight, .bottomLeft:
            let k = y - x
//            print("함수는 y = x + \(k)")
            if -k >= 0 && -k <= width && direction == .bottomLeft {
                return CollideInfo(nextPoint: CGPoint(x: -k, y: height), direction: .vertical)
            } else if width+k >= 0 && width+k <= height && direction == .topRight {
                return CollideInfo(nextPoint: CGPoint(x: width, y: height - width - k), direction: .horizontal)
            } else if height-k >= 0 && height-k <= width && direction == .topRight {
                return CollideInfo(nextPoint: CGPoint(x: height-k, y: 0), direction: .vertical)
            } else {
                return CollideInfo(nextPoint: CGPoint(x: 0, y: height-k), direction: .horizontal)
            }
        case .topLeft, .bottomRight:
            let k = x + y

            if k >= 0 && k <= width && direction == .bottomRight {
                return CollideInfo(nextPoint: CGPoint(x: k, y: height), direction: .vertical)
            } else if k >= 0 && k <= height && direction == .topLeft {
                return CollideInfo(nextPoint: CGPoint(x: 0, y: height - k), direction: .horizontal)
            } else if k-height >= 0 && k-height <= width && direction == .topLeft {
                return CollideInfo(nextPoint: CGPoint(x: k - height, y: 0), direction: .vertical)
            } else {
                return CollideInfo(nextPoint: CGPoint(x: width, y: width + height - k), direction: .horizontal)
            }
        }
    }
}

// MARK: - Value Fucntions
extension ABBoundingView {
    private func makeDirection() -> ProgressDirection {
        return [.topRight, .topLeft, .bottomRight, .bottomLeft].randomElement()!
    }
    
    private func makeNextDirection(current: ProgressDirection, collide: CollideDirection) -> ProgressDirection {
        
        switch current {
        case .topRight:
            if collide == .vertical { return [.bottomRight, .bottomLeft].randomElement()! }
            else { return [.topLeft, .bottomLeft].randomElement()! }
        case .topLeft:
            if collide == .vertical { return [.bottomLeft, .bottomRight].randomElement()! }
            else { return [.topRight, .bottomLeft].randomElement()! }
        case .bottomRight:
            if collide == .vertical { return [.topRight, .topLeft].randomElement()! }
            else { return [.bottomLeft, .topLeft].randomElement()! }
        case .bottomLeft:
            if collide == .vertical { return [.topLeft, .topRight].randomElement()! }
            else { return [.bottomRight, .topRight].randomElement()! }
        }
        
    }
    
    private func makeDurationTime(current: CGPoint, next: CGPoint) -> CGFloat {
        let distance = CGPointDistance(from: current, to: next)
        return distance / option.velocity
    }
}

// MARK: - Utility
extension ABBoundingView {
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}
