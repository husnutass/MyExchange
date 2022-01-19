//
//  UIView+Extension.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

extension UIView {
    /// Covers the given view completely
    func expandView(to superView: UIView) {
        topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    /// Covers the given view with equal margins
    func expandView(to superView: UIView, with constant: CGFloat?) {
        let negativeConst = -(constant ?? 0)
        topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant ?? 0).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: negativeConst).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant ?? 0).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: negativeConst).isActive = true
    }
    
    /// Covers the given view with the given margins
    func expandView(to superView: UIView, top: CGFloat?, bottom: CGFloat?, leading: CGFloat?, trailing: CGFloat?) {
        topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: top ?? 0).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: bottom ?? 0).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leading ?? 0).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: trailing ?? 0).isActive = true
    }
    
    /// Centers to the given view
    func centerView(to superView: UIView) {
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    /// Centers to the given view with the given x, y constants
    func centerView(to superView: UIView, x: CGFloat, y: CGFloat) {
        centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: x).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: y).isActive = true
    }
}
