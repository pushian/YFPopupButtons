//
//  MainTabBarViewController.swift
//  YFPopupButtons
//
//  Created by Yangfan Liu on 3/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        // Do any additional setup after loading the view.
        prepareTabs()
        selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareTabs() {
        let nameArr = ["Tab", "Tab", "Tab", "Tab", "Tab"]
        tabBar.tintColor = UIColor.redColor()
        var controllers = [UIViewController]()
        for index in 0..<nameArr.count {
            let rootVc = viewControllerAtIndex(index)
            let nav = UINavigationController(rootViewController: rootVc)
            let tabItem = UITabBarItem(title: nameArr[index], image: nil, selectedImage: nil)
            nav.tabBarItem = tabItem
            controllers.append(nav)
        }
        viewControllers = controllers
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        switch index {
        case 0:
            return ViewController()
        case 1:
            return ViewController()
        case 2:
            return ViewController()
        case 3:
            return ViewController()
        default:
            return ViewController()
        }
    }
    
}
