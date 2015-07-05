//
//  UIView+WCLayout.swift
//  SuperGina
//
//  Created by 王策 on 15/6/17.
//  Copyright (c) 2015年 Anve. All rights reserved.
//

import UIKit

///	屏幕高度
public var WCScreenHeight : CGFloat {
	return WCScreenBounds.size.height
}

///	屏幕宽度
public var WCScreenWidth : CGFloat {
	return WCScreenBounds.size.width
}

///	屏幕 Bounds
public var WCScreenBounds = UIScreen.mainScreen().bounds

/// 居中的 frame，可以理解为CGCenterRectMake
public func CM(#y: CGFloat, #width: CGFloat, #height: CGFloat) -> CGRect {
	return CGRect(x: (WCScreenWidth - width)/2, y: y, width: width, height: height)
}

public extension CGRect {
	
	var x: CGFloat {
		get {
			return origin.x
		}
		set {
			origin.x = newValue
		}
	}
	var y: CGFloat {
		get {
			return origin.y
		}
		set {
			origin.y = newValue
		}
	}
	var width: CGFloat {
		get {
			return size.width
		}
		set {
			size.width = newValue
		}
	}
	var height: CGFloat {
		get {
			return size.height
		}
		set {
			size.height = newValue
		}
	}
	var chainRight: CGFloat {
		return x + width
	}
	var chainBottom: CGFloat {
		return y + height
	}
	
}

private var X: Int8 = 0
private var Y: Int8 = 0

public extension UIView {
	
	private var rulerX: WCLayoutRuler {
		if objc_getAssociatedObject(self, &X) == nil {
			objc_setAssociatedObject(self, &X, WCLayoutRuler(), objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
		}
		return objc_getAssociatedObject(self, &X) as! WCLayoutRuler
	}
	
	private var rulerY: WCLayoutRuler {
		if objc_getAssociatedObject(self, &Y) == nil {
			objc_setAssociatedObject(self, &Y, WCLayoutRuler(), objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
		}
		return objc_getAssociatedObject(self, &Y) as! WCLayoutRuler
	}
	
	func x(x:CGFloat) -> Self {
		self.x = x
		return self
	}
	
	func y(y:CGFloat) -> Self {
		self.y = y
		return self
	}
	
	func left(left:CGFloat) -> Self {
		self.left = left
		return self
	}
	
	func right(right:CGFloat) -> Self {
		self.right = right
		return self
	}
	
	func top(top:CGFloat) -> Self {
		self.top = top
		return self
	}
	
	func bottom(bottom:CGFloat) -> Self {
		self.bottom = bottom
		return self
	}
	
	func height(height:CGFloat) -> Self {
		self.height = height
		return self
	}
	
	func width(width:CGFloat) -> Self {
		self.width = width
		return self
	}
	
	func size(size:CGSize) -> Self {
		self.size = size
		return self
	}
	
	func size(#width: CGFloat, height:CGFloat) -> Self {
		return self.size(CGSize(width: width, height: height))
	}
	
	func origin(origin:CGPoint) -> Self {
		self.origin = origin
		return self
	}
	
	func origin(#x:CGFloat, y:CGFloat) -> Self {
		return self.origin(CGPoint(x: x, y: y))
	}
	
	func center(center:CGPoint) -> Self {
		self.center = center
		return self
	}
	
	private var hasNoSuperView : Bool {
		if superview == nil {
			tellHasNoSuperView()
			return true
		} else {
			return false
		}
	}
	
	private func tellHasNoSuperView() {
		println("⚠️WCLayout: You must set superView before use WCLayout!")
	}
	
	private var x: CGFloat {
		get {
			return frame.x
		}
		set {
			if hasNoSuperView {
				return
			}
			frame.x = newValue
			rulerX.x = newValue
			if rulerX.z != nil {
				frame.width = superview!.width - x - rulerX.z!
			}
		}
	}
	
	var left: CGFloat {
		get {
			return x
		}
		set {
			x = newValue
		}
	}
	
	var chainLeft : CGFloat {
		if hasNoSuperView {
			return 0
		}
		return superview!.width - left
	}
	
	var width: CGFloat {
		get {
			return frame.width
		}
		set {
			if hasNoSuperView {
				return
			}
			frame.width = newValue
			rulerX.y = newValue
			if rulerX.z != nil {
				frame.x = superview!.width - width - rulerX.z!
			}
		}
	}
	
	var right: CGFloat {
		get {
			if hasNoSuperView {
				return 0
			}
			return superview!.width - chainRight
		}
		set {
			if hasNoSuperView {
				return
			}
			rulerX.z = newValue
			if rulerX.x != nil {
				frame.width = superview!.width - x - rulerX.z!
			} else {
				frame.x = superview!.width - width - rulerX.z!
			}
		}
	}
	
	var chainRight: CGFloat {
		return x + width
	}
	
	private var y: CGFloat {
		get {
			return frame.y
		}
		set {
			if hasNoSuperView {
				return
			}
			frame.y = newValue
			rulerY.x = newValue
			if rulerY.z != nil {
				frame.height = superview!.height - y - rulerY.z!
			}
		}
	}
	
	var top: CGFloat {
		get {
			return y
		}
		set {
			y = newValue
		}
	}
	
	var height: CGFloat {
		get {
			return frame.height
		}
		set {
			if hasNoSuperView {
				return
			}
			frame.height = newValue
			rulerY.y = newValue
			if rulerY.z != nil {
				frame.y = superview!.height - height - rulerY.z!
			}
		}
	}
	
	var bottom: CGFloat {
		get {
			if hasNoSuperView {
				return 0
			}
			return superview!.height - chainBottom
		}
		set {
			if hasNoSuperView {
				return
			}
			rulerY.z = newValue
			if rulerY.x != nil {
				frame.height = superview!.height - y - rulerY.z!
			} else {
				frame.y = superview!.height - height - rulerY.z!
			}
		}
	}
	
	var chainBottom: CGFloat {
		return y + height
	}
	
	var chainTop : CGFloat {
		if hasNoSuperView {
			return 0
		}
		return superview!.height - y
	}
	
	var origin: CGPoint {
		get {
			return frame.origin
		}
		set {
			x = newValue.x
			y = newValue.y
		}
	}
	
	var size: CGSize {
		get {
			return frame.size
		}
		set {
			width = newValue.width
			height = newValue.height
		}
	}
	
	var reOrigin: CGPoint {
		get {
			return CGPoint(x: right, y: bottom)
		}
		set {
			right = newValue.x
			bottom = newValue.y
		}
	}
	
	func centerVertically() -> Self {
		if hasNoSuperView {
			return self
		}
		y = ((superview!.height - height)/2)
		return self
	}
	
	func centerHorizontally() -> Self {
		if hasNoSuperView {
			return self
		}
		x = ((superview!.width - width)/2)
		return self
	}
}

private class WCLayoutRuler: NSObject {
	private var			constraint_X: WCLayoutConstraint?
	private var			constraint_Y: WCLayoutConstraint?
	private var			constraint_Z: WCLayoutConstraint?
	private weak var	constraint_last: WCLayoutConstraint?
	private weak var	constraint_early: WCLayoutConstraint?
	
	// TODO: 下面这些陈宏福的代码应该怎么优化？
	
	/// 第一约束
	var x: CGFloat? {
		get {
			return constraint_X?.value
		}
		set {
			//  如果没有最后约束的话，直接给最后约束赋值
			if constraint_last == nil {
				constraint_X = WCLayoutConstraint(value: newValue!)
				constraint_last = constraint_X
				return
			} else {
				//  如果最近约束等于要设定的约束，直接给最近约束赋值
				if constraint_X == constraint_last {
					constraint_X = WCLayoutConstraint(value: newValue!)
					constraint_last = constraint_X
				} else {
					//  如果不等于最近约束
					//  将较早约束所对应的约束重置
					if constraint_early == constraint_Y {
						constraint_Y = nil
					} else if constraint_early == constraint_Z {
						constraint_Z = nil
					}
					//  旧的最近约束变为较早约束
					constraint_early = constraint_last
					//  给X赋值
					constraint_X = WCLayoutConstraint(value: newValue!)
					//  将最近约束改为所赋值的约束
					constraint_last = constraint_X
				}
			}
		}
	}
	
	/// 第二约束
	var y: CGFloat? {
		get {
			return constraint_Y?.value
		}
		set {
			if constraint_last == nil {
				constraint_Y = WCLayoutConstraint(value: newValue!)
				constraint_last = constraint_Y
				return
			} else {
				if constraint_Y == constraint_last {
					constraint_Y = WCLayoutConstraint(value: newValue!)
					constraint_last = constraint_Y
				} else {
					if constraint_early == constraint_X {
						constraint_X = nil
					} else if constraint_early == constraint_Z {
						constraint_Z = nil
					}
					constraint_early = constraint_last
					constraint_Y = WCLayoutConstraint(value: newValue!)
					constraint_last = constraint_Y
				}
			}
		}
	}
	
	/// 第三约束
	var z: CGFloat? {
		get {
			return constraint_Z?.value
		}
		set {
			if constraint_last == nil {
				constraint_Z = WCLayoutConstraint(value: newValue!)
				constraint_last = constraint_Z
				return
			} else {
				if constraint_Z == constraint_last {
					constraint_Z = WCLayoutConstraint(value: newValue!)
					constraint_last = constraint_Z
				} else {
					if constraint_early == constraint_X {
						constraint_X = nil
					} else if constraint_early == constraint_Y {
						constraint_Y = nil
					}
					constraint_early = constraint_last
					constraint_Z = WCLayoutConstraint(value: newValue!)
					constraint_last = constraint_Z
				}
			}
		}
	}
	
	override var description : String {
		return "\(self) -> x: \(x), y: \(y), z: \(z)"
	}

}

private class WCLayoutConstraint: NSObject {
	let value: CGFloat
	init(value: CGFloat) {
		self.value = value
		super.init()
	}
}


