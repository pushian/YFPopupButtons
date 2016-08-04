//
//  YFPopupButtonsView.swift
//  YFPopupButtons
//
//  Created by Yangfan Liu on 3/8/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFPopupButtonsView: UIView {
    
    //MARK: Public Variables
    public weak var delegate: YFPopupBottonsViewDelegate? {
        didSet {
            initialCommit()
        }
    }
    
    //MARK: Public Functions
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        cancelButton.image = loadBundleImage("YFPopupButtonsCross")
        clipsToBounds = true
        userInteractionEnabled = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        overlay.addGestureRecognizer(gesture)
        self.addSubview(overlay)
        self.addSubview(cancelButton)
        let gestureTwo = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        cancelButton.addGestureRecognizer(gestureTwo)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialCommit() {
        if let delegate = delegate {
            setConstraints()
            let width = sideMargin + sideMargin + CGFloat(delegate.maxNumberOfItemsInRow(self)) * delegate.itemSize(self).width
            let itemSpace = (UIScreen.mainScreen().bounds.width - width) / CGFloat(delegate.maxNumberOfItemsInRow(self) - 1)
            setItemConstrains(itemSpace)
        }
    }
    
    public func show() {
        self.overlay.hidden = false
        self.userInteractionEnabled = true
        popButtons()
    }
    
    public func dismiss() {
        self.overlay.hidden = true
        self.userInteractionEnabled = false
        dismissButtons()
    }
    
    //MARK: Private Variables
    var sideMargin: CGFloat {
        if let margin = delegate?.sideMargin?(self) {
            return margin
        } else {
            return 50
        }
    }
    var spaceBetweenRows: CGFloat {
        if let space = delegate?.spaceBetweenRows?(self) {
            return space
        } else {
            return 10
        }
    }
    
    var overlay: UIView! = {
        let t = UIView()
        t.backgroundColor = .blackColor()
        t.userInteractionEnabled = true
        t.alpha = 0.5
        t.hidden = true
        return t
    }()
    var cancelButton: UIImageView! = {
        let t = UIImageView()
        t.contentMode = .ScaleAspectFill
        t.backgroundColor = .clearColor()
        t.userInteractionEnabled = true
//        t.image = UIImage(named: "YFPopupButtonsCross")
        return t
    }()
    var totalRowNum: Int {
        return Int(ceil(Double(delegate!.numOfItems(self)) / Double(delegate!.maxNumberOfItemsInRow(self))))
    }
    var totalHeight: CGFloat {
        return CGFloat(totalRowNum) * (delegate!.itemSize(self).height + spaceBetweenRows) + 70 + 10
    }
    var buttons = [YFPopupbotton]()
    var bigButtons = [UIButton]()
    
    //MARK: Private Functions
    func tapHandler() {
        dismiss()
    }
    func bigButtonHandler(sender: UIButton) {
        let index = sender.tag
        delegate?.buttonsView(self, didTapItemAtIndex: index)
    }
    func popButtons() {
        if let delegate = delegate {
            delegate.buttonsViewWillAppear?(self)
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6,
                                       initialSpringVelocity: 0.1,
                                       options: UIViewAnimationOptions.CurveLinear,
                                       animations: {
                                        self.cancelButton.transform = CGAffineTransformMakeTranslation(0, -self.totalHeight)
                }, completion: nil)
            
            for index in (0..<delegate.numOfItems(self)) {
                self.bigButtons[index].transform = CGAffineTransformMakeTranslation(0, -self.totalHeight)
                let itemNum = index % delegate.maxNumberOfItemsInRow(self)
                UIView.animateWithDuration(1, delay: 0.1 * Double(itemNum), usingSpringWithDamping: 0.6,
                                           initialSpringVelocity: 0.1,
                                           options: UIViewAnimationOptions.CurveLinear,
                                           animations: {
                                            self.buttons[index].transform = CGAffineTransformMakeTranslation(0, -self.totalHeight)
                    }, completion: nil)
            }
        }
    }
    func dismissButtons() {
        if let delegate = delegate {
            delegate.buttonsViewWillDisappear?(self)
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6,
                                       initialSpringVelocity: 0.1,
                                       options: UIViewAnimationOptions.CurveLinear,
                                       animations: {
                                        self.cancelButton.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: { (check) in
                    //                    self.hidden = true
            })
            
            for index in (0..<delegate.numOfItems(self)) {
                self.bigButtons[index].transform = CGAffineTransformMakeTranslation(0, 0)
                let itemNum = index % delegate.maxNumberOfItemsInRow(self)
                UIView.animateWithDuration(1, delay: 0.1 * Double(itemNum), usingSpringWithDamping: 0.6,
                                           initialSpringVelocity: 0.1,
                                           options: UIViewAnimationOptions.CurveLinear,
                                           animations: {
                                            self.buttons[index].transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: { (check) in
                        //                    self.hidden = true
                })
            }
        }
    }
    func setConstraints() {
        self.overlay.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: self.overlay, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.overlay, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.overlay, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.overlay, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0)
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -30 + totalHeight)
        let centerXConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        let heightConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20)
        let widthConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20)
        self.addConstraints([bottomConstraintTwo, centerXConstraintTwo, heightConstraintTwo, widthConstraintTwo])
    }
    
    func setItemConstrains(itemSpace: CGFloat) {
        for each in overlay.subviews {
            each.removeFromSuperview()
        }
        for index in (0..<delegate!.numOfItems(self)) {
            let rowNum = index / delegate!.maxNumberOfItemsInRow(self)
            let itemNum = index % delegate!.maxNumberOfItemsInRow(self)
            let button = (delegate?.buttonsView(self, itemForIndex: index))!
            buttons.append(button)
            self.addSubview(button)
            let bigButton = UIButton()
            bigButtons.append(bigButton)
            bigButton.backgroundColor = .clearColor()
            self.addSubview(bigButton)
            bigButton.tag = index
            bigButton.addTarget(self, action: #selector(bigButtonHandler(_:)), forControlEvents: .TouchUpInside)
            bigButton.translatesAutoresizingMaskIntoConstraints = false
            if delegate!.numOfItems(self) < delegate!.maxNumberOfItemsInRow(self) {
                if delegate!.numOfItems(self) == 1 {
                    let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                    let centerX = NSLayoutConstraint(item: bigButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
                    let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                    let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).width)
                    self.addConstraints([bottomConstraint, centerX, heightConstraint, widthConstraint])
                } else {
                    if itemNum == 0 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: sideMargin + delegate!.itemSize(self).width / 2)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                        self.addConstraints([bottomConstraint, centerX, heightConstraint])
                    } else if itemNum == delegate!.numOfItems(self) - 1 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .Leading, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Trailing, multiplier: 1, constant: 0)
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: -(sideMargin + delegate!.itemSize(self).width / 2))
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .Width, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, centerX, leadingConstraint, heightConstraint, widthConstraint])
                    } else {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .Leading, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Trailing, multiplier: 1, constant: 0)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .Width, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, leadingConstraint, heightConstraint, widthConstraint])
                    }
                }
            } else {
                if rowNum == 0 {
                    if itemNum == 0 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: sideMargin + delegate!.itemSize(self).width / 2)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                        self.addConstraints([bottomConstraint, centerX, heightConstraint])
                    } else if itemNum == delegate!.maxNumberOfItemsInRow(self) - 1 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .Leading, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Trailing, multiplier: 1, constant: 0)
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: -(sideMargin + delegate!.itemSize(self).width / 2))
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .Width, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, centerX, leadingConstraint, heightConstraint, widthConstraint])
                    } else {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .Leading, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Trailing, multiplier: 1, constant: 0)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .Width, relatedBy: .Equal, toItem: bigButtons[index - 1], attribute: .Width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, leadingConstraint, heightConstraint, widthConstraint])
                    }
                } else {
                    let preIndex = index - delegate!.maxNumberOfItemsInRow(self)
                    let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(self).height))
                    let centerX = NSLayoutConstraint(item: bigButton, attribute: .CenterX, relatedBy: .Equal, toItem: bigButtons[preIndex], attribute: .CenterX, multiplier: 1, constant: 0)
                    let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).height)
                    let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .Width, relatedBy: .Equal, toItem: bigButtons[preIndex], attribute: .Width, multiplier: 1, constant: 0)
                    self.addConstraints([bottomConstraint, centerX, heightConstraint, widthConstraint])
                }
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            let bottomConstraintTwo = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: bigButton, attribute: .Bottom, multiplier: 1, constant: 0)
            let topConstraintTwo = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: bigButton, attribute: .Top, multiplier: 1, constant: 0)
            let centerX = NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: bigButton, attribute: .CenterX, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: delegate!.itemSize(self).width)
            self.addConstraints([bottomConstraintTwo, topConstraintTwo, centerX, widthConstraint])
        }
    }
    
}

extension YFPopupButtonsView {
    func loadBundleImage(name: String) -> UIImage? {
        let podBundle = NSBundle(forClass: YFPopupButtonsView.self)
        if let url = podBundle.URLForResource("YFPopupButtons", withExtension: "bundle") {
            let bundle = NSBundle(URL: url)
            return UIImage(named: name, inBundle: bundle, compatibleWithTraitCollection: nil)
        }
        return nil
    }
}
