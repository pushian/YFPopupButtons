//
//  ViewController.swift
//  YFPopupButtons
//
//  Created by pushian on 08/03/2016.
//  Copyright (c) 2016 pushian. All rights reserved.
//

import UIKit
import YFPopupButtons

class ViewController: UIViewController {
    var button: UIButton! = {
        let t = UIButton()
        t.backgroundColor = .orangeColor()
        t.layer.cornerRadius = 30
        t.clipsToBounds = true
        t.setTitle("Tap", forState: .Normal)
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonView: YFPopupButtonsView = {
        let t = YFPopupButtonsView()
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(button)
        view.addSubview(buttonView)
        buttonView.delegate = self
        button.addTarget(self, action: #selector(buttonHandler), forControlEvents: .TouchUpInside)
        setConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonHandler() {
        buttonView.show()
    }
    
    func setConstraints() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: self.button, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.button, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: self.button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60)
        let widthConstraint = NSLayoutConstraint(item: self.button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60)
        self.view.addConstraints([topConstraint, bottomConstraint, heightConstraint, widthConstraint])
        
        self.buttonView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0)
        let bottomConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0)
        let leadingConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0)
        let trailingConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: 0)
        self.view.addConstraints([topConstraintTwo, bottomConstraintTwo, leadingConstraintTwo, trailingConstraintTwo])
    }
}

extension ViewController: YFPopupBottonsViewDelegate {
    // Not optional!!!
    func numOfItems(buttonsView: YFPopupButtonsView) -> Int {
        return 6
    }
    func maxNumberOfItemsInRow(buttonsView: YFPopupButtonsView) -> Int {
        return 3
    }
    func itemSize(buttonsView: YFPopupButtonsView) -> CGSize {
        return CGSize(width: 70, height: 90)
    }
    func buttonsView(buttonsView: YFPopupButtonsView, itemForIndex index: Int) -> YFPopupbotton {
        let button = YFPopupbotton(contentImage: UIImage(named: "fbIcon")!, title: "Title")
        button.contentImageView.layer.cornerRadius = 35
        button.contentImageView.backgroundColor = .whiteColor()
        button.contentImageView.contentMode = .ScaleAspectFill
        return button
    }
    func buttonsView(buttonsView: YFPopupButtonsView, didTapItemAtIndex index: Int) {
        debugPrint(index)
    }
    
    // Optional
    func buttonsViewWillAppear(buttonsView: YFPopupButtonsView) {
        debugPrint("will appear")
        navigationController?.navigationBar.userInteractionEnabled = false
        tabBarController?.tabBar.userInteractionEnabled = false
        self.navigationController?.navigationBar.layer.zPosition = -1
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    
    func buttonsViewWillDisappear(buttonsView: YFPopupButtonsView) {
        debugPrint("will disappear")
        navigationController?.navigationBar.userInteractionEnabled = true
        tabBarController?.tabBar.userInteractionEnabled = true
        self.navigationController?.navigationBar.layer.zPosition = 0.0
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
    
    func sideMargin(buttonsView: YFPopupButtonsView) -> CGFloat {
        return 50
    }
    
    func spaceBetweenRows(buttonsView: YFPopupButtonsView) -> CGFloat {
        return 20
    }
}

