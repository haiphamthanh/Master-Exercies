//
//  ViewController.swift
//  TestRxSwift
//
//  Created by HaiKaito on 8/5/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit
import RxSwift

//class Person: NSObject {
//	@objc dynamic var age: Int = 0
//	@objc dynamic var name: String = ""
//}

//class PersonObserver {
//
//	var kvoToken: NSKeyValueObservation?
//
//	func observe(person: Person) {
//		kvoToken = person.observe(\.age, options: .new) { (person, change) in
//			guard let age = change.newValue else { return }
//			print("New age is: \(age)")
//		}
//	}
//
//	deinit {
//		kvoToken?.invalidate()
//	}
//}

class Person: NSObject {
	@objc dynamic var age: Int = 0
	@objc dynamic var name: String = ""
}

class ViewController: UIViewController {
	
	let pub = PublishSubject<String>()
	let beh = BehaviorSubject<String>(value: "Fisrt")
	let rep = ReplaySubject<String>.create(bufferSize: 5)
	let vab = Variable<String>("Fisrt")

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
//		var pers = Person()
//
//
//		pers.addObserver(self, forKeyPath: "name", options: [.new, .old], context: nil)
//		pers.addObserver(self, forKeyPath: "age", options: [.old], context: nil)
		
//		pers.age = 10
//		pers.setValue("name 01", forKey: "name")
//
//		pers.age = 100
//		pers.setValue("name 02", forKey: "name")
//
//		pers.age = 1000
//		pers.setValue("name 03", forKey: "name")
		
//		pers.setValue(10000, forKey: "age")
//		pers.setValue("name 04", forKey: "name")
		
//		print("\(pers.age)")
//		print("\(pers.name)")
		
//		testPublishSubject()
//		testBehaviorSubject()
//		testReplaySubject()
		
//		vab.value = "Samething 1"
//		vab.asObservable().subscribe { value in
//			print("\(value)")
//		}
//		vab.value = "Samething 2"
		
		
		
	}
	@IBAction func click(_ sender: Any) {
		
		testing()
	}
	
	let queue = DispatchQueue(label: "Sample", qos: .background)
	let queue2 = DispatchQueue(label: "Sample2", qos: .background)
	
	func testing() {
		
		
//		let mainQueue = DispatchQueue.main			// Serial QUEUE có sẵn
//		let globalQueue = DispatchQueue.global()	// Concurrent QUEUE có sẵn
////		let queue = DispatchQueue(label: "myQueue") // Tự tạo một QUEUEU mới với định danh là myQueue
//		globalQueue.async { [weak self] in
//			self?.queue2.sync {
//				print("Chekc thread")
//				self?.queue.sync { // Dispatch một Task với phương thức hoạt động đồng bộ vào QUEUE có định danh là myQueue (sync hoặc async)
//			  // -----> START TASK
//			  for i in 0..<1000000 {
//				  print("Running at \(i)")
//			  }
//
//			  print("Task has completed")
//			  // END TASK <-----
//		  }
//
//			 self?.queue.async {
//			  for i in 0..<1000000 {
//  //				print("\(i)")
//			  }
//
//  //			while(true) {
//  ////				print("\(i)")
//  //			}
//
//			  print("has completed")
//			}
//		 }
//		}
//
//		print("Done")
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		let object = object as! Person
		print("\(object.name) \(object.age)")
	}
	
	func testPublishSubject() {
		pub.onNext("Emit 1")
		pub.onNext("Emit 2")
		pub.onNext("Emit 3")
		
		// subcribe
		pub.subscribe { value in
			print("pub \(value)")
		}
		
		pub.onNext("Emit 4")
		pub.onNext("Emit 5")
		pub.onNext("Emit 6")
	}
	
	func testBehaviorSubject() {
		beh.onNext("Emit 1")
		beh.onNext("Emit 2")
		beh.onNext("Emit 3")
		
		// subcribe
		beh.subscribe { value in
			print("beh \(value)")
		}
		
		beh.onNext("Emit 4")
		beh.onNext("Emit 5")
		beh.onNext("Emit 6")
	}
	
	func testReplaySubject() {
		rep.onNext("Emit 1")
		rep.onNext("Emit 2")
		rep.onNext("Emit 3")
		
		// subcribe
		rep.subscribe { value in
			print("rep \(value)")
		}
		
		rep.onNext("Emit 4")
		rep.onNext("Emit 5")
		rep.onNext("Emit 6")
	}


}

