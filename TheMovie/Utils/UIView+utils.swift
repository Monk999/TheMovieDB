//
//  UIView+utils.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
    
    func forAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach({ self.addArrangedSubview($0) })
    }
}


public protocol ReusableView: AnyObject {
    /// Represents the reusesable identifier for a cell
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    /// Set the reuse identifier to be equal to the class name
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
