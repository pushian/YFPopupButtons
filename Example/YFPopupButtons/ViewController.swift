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
//    var button: UIButton! = {
//        let t = UIButton()
//        t.backgroundColor = .orange
//        t.layer.cornerRadius = 30
//        t.clipsToBounds = true
//        t.setTitle("Tap", for: .normal)
//        t.setTitleColor(.white, for: .normal)
//        return t
//    }()
//    
//    var buttonView: YFPopupButtonsView = {
//        let t = YFPopupButtonsView()
//        return t
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        view.addSubview(button)
//        view.addSubview(buttonView)
//        buttonView.delegate = self
//        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
//        setConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func buttonHandler() {
//        buttonView.show()
//    }
//    
//    func setConstraints() {
//        self.button.translatesAutoresizingMaskIntoConstraints = false
//        let topConstraint = NSLayoutConstraint(item: self.button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
//        let bottomConstraint = NSLayoutConstraint(item: self.button, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
//        let heightConstraint = NSLayoutConstraint(item: self.button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
//        let widthConstraint = NSLayoutConstraint(item: self.button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
//        self.view.addConstraints([topConstraint, bottomConstraint, heightConstraint, widthConstraint])
//        
//        self.buttonView.translatesAutoresizingMaskIntoConstraints = false
//        let topConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
//        let bottomConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
//        let leadingConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
//        let trailingConstraintTwo = NSLayoutConstraint(item: self.buttonView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
//        self.view.addConstraints([topConstraintTwo, bottomConstraintTwo, leadingConstraintTwo, trailingConstraintTwo])
//    }
}

//extension ViewController: YFPopupBottonsViewDelegate {
//    // Not optional!!!
//    func numOfItems(buttonsView: YFPopupButtonsView) -> Int {
//        return 6
//    }
//    func maxNumberOfItemsInRow(buttonsView: YFPopupButtonsView) -> Int {
//        return 3
//    }
//    func itemSize(buttonsView: YFPopupButtonsView) -> CGSize {
//        return CGSize(width: 60, height: 80)
//    }
//    func buttonsView(buttonsView: YFPopupButtonsView, itemForIndex index: Int) -> YFPopupbotton {
//        let button = YFPopupbotton(contentImage: UIImage(named: "fbIcon")!, title: "Title")
//        button.contentImageView.layer.cornerRadius = 30
//        button.contentImageView.backgroundColor = .white
//        button.contentImageView.contentMode = .scaleAspectFill
//        return button
//    }
////    func buttonsView(buttonsView: YFPopupButtonsView, itemForIndex index: Int) -> YFPopupbotton {
////        return YFPopupbotton(contentImage: UIImage(named: "fbIcon")!, title: "Title")
////    }
//    func buttonsView(buttonsView: YFPopupButtonsView, didTapItemAtIndex index: Int) {
//        debugPrint(index)
//    }
//    
//    // Optional
//    func buttonsViewWillAppear(buttonsView: YFPopupButtonsView) {
//        debugPrint("will appear")
//        navigationController?.navigationBar.isUserInteractionEnabled = false
//        tabBarController?.tabBar.isUserInteractionEnabled = false
//        self.navigationController?.navigationBar.layer.zPosition = -1
//        self.tabBarController?.tabBar.layer.zPosition = -1
//    }
//    
//    func buttonsViewWillDisappear(buttonsView: YFPopupButtonsView) {
//        debugPrint("will disappear")
//        navigationController?.navigationBar.isUserInteractionEnabled = true
//        tabBarController?.tabBar.isUserInteractionEnabled = true
//        self.navigationController?.navigationBar.layer.zPosition = 0.0
//        self.tabBarController?.tabBar.layer.zPosition = 0
//    }
//    
//    func sideMargin(buttonsView: YFPopupButtonsView) -> CGFloat {
//        return 40
//    }
//    
//    func spaceBetweenRows(buttonsView: YFPopupButtonsView) -> CGFloat {
//        return 15
//    }
//}

