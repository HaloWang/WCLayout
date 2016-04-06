# WCLayout

## Update

已经有了新的[实现](https://github.com/HaloWang/FangYuan)

<del>😅很多第三方布局库要写的比我这个好啊，不过我这个好歹也在一个项目中大量使用过。到现在我已经停止维护这个库了。

<del>**这个库就作为一个纪念吧！**

## Usage

假设我们想达到这样的需求：

![1](https://github.com/HaloWang/WCLayout/blob/master/readme_1.png?raw=true)

	1、testView_A
		距离顶部30，距离右侧30，高度为100，距离左侧30
	2、testView_B
		距离 testView_A 的底部 25
		距离 superView 左侧的距离等于 testView_A 距离 superView 左侧的距离
		距离 superView 右侧的距离等于 testView_A 距离 superView 右侧的距离 + 10
		距离 superView 底部的距离等于 30

#### 不使用任何第三方布局方式：

	class ViewController: UIViewController {
	
		let testView_A = UILabel()
	
		let testView_B = UILabel()

		override func viewDidLoad() {
			super.viewDidLoad()
		
			view.addSubview(testView_A)
			view.addSubview(testView_B)
		
			testView_A.text = "testView_A"
			testView_B.text = "testView_B"
		
			var frameA = CGRectZero
			frameA.origin.x = 30
			frameA.origin.y = 30
			frameA.size.width = UIScreen.mainScreen().bounds.size.width - frameA.origin.x - 30
			frameA.size.height = 100
			testView_A.frame = frameA
		
			var frameB = CGRectZero
			frameB.origin.x = testView_A.frame.origin.x
			frameB.origin.y = testView_A.frame.origin.y + testView_A.frame.size.height + 25
			frameB.size.width = UIScreen.mainScreen().bounds.size.width - testView_A.frame.origin.x - (testView_A.superview!.frame.size.width - (testView_A.frame.origin.x + testView_A.frame.size.width)) - 10
			frameB.size.height = UIScreen.mainScreen().bounds.size.height - frameB.origin.y - 30
			testView_B.frame = frameB
		
		
			testView_A.backgroundColor = UIColor.redColor()
			testView_B.backgroundColor = UIColor.blueColor()
		}
	}
	
#### 使用WCLayout：

	
	import UIKit
	import WCLayout

	class ViewController: UIViewController {
		
		let testView_A = UILabel()
		
		let testView_B = UILabel()

		override func viewDidLoad() {
			super.viewDidLoad()
			
			view.addSubview(testView_A)
			view.addSubview(testView_B)
			
			testView_A.text = "testView_A"
			testView_B.text = "testView_B"
			
			testView_A
				.top(30)
				.right(30)
				.height(100)
				.left(30)
			
			testView_B
				.top(testView_A.chainBottom + 25)
				.left(testView_A.left)
				.right(testView_A.right + 10)
				.bottom(30)
			
			testView_A.backgroundColor = UIColor.redColor()
			testView_B.backgroundColor = UIColor.blueColor()
		}
	}

