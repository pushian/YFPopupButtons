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
        cancelButton.image = loadBundleImage(name: "YFPopupButtonsCross")
        clipsToBounds = true
        isUserInteractionEnabled = false
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
            let width = sideMargin + sideMargin + CGFloat(delegate.maxNumberOfItemsInRow(buttonsView: self)) * delegate.itemSize(buttonsView: self).width
            let itemSpace = (UIScreen.main.bounds.width - width) / CGFloat(delegate.maxNumberOfItemsInRow(buttonsView: self) - 1)
            setItemConstrains(itemSpace: itemSpace)
        }
    }
    
    public func show() {
        self.overlay.isHidden = false
        self.isUserInteractionEnabled = true
        popButtons()
    }
    
    public func dismiss() {
        self.overlay.isHidden = true
        self.isUserInteractionEnabled = false
        dismissButtons()
    }
    
    //MARK: Private Variables
    var sideMargin: CGFloat {
        if let margin = delegate?.sideMargin?(buttonsView: self) {
            return margin
        } else {
            return 50
        }
    }
    var spaceBetweenRows: CGFloat {
        if let space = delegate?.spaceBetweenRows?(buttonsView: self) {
            return space
        } else {
            return 10
        }
    }
    
    var overlay: UIView! = {
        let t = UIView()
        t.backgroundColor = .black
        t.isUserInteractionEnabled = true
        t.alpha = 0.5
        t.isHidden = true
        return t
    }()
    var cancelButton: UIImageView! = {
        let t = UIImageView()
        t.contentMode = .scaleAspectFill
        t.backgroundColor = .clear
        t.isUserInteractionEnabled = true
//        t.image = UIImage(named: "YFPopupButtonsCross")
        return t
    }()
    var totalRowNum: Int {
        return Int(ceil(Double(delegate!.numOfItems(buttonsView: self)) / Double(delegate!.maxNumberOfItemsInRow(buttonsView: self))))
    }
    var totalHeight: CGFloat {
        return CGFloat(totalRowNum) * (delegate!.itemSize(buttonsView: self).height + spaceBetweenRows) + 70 + 10
    }
    var buttons = [YFPopupbotton]()
    var bigButtons = [UIButton]()
    
    //MARK: Private Functions
    func tapHandler() {
        dismiss()
    }
    func bigButtonHandler(sender: UIButton) {
        let index = sender.tag
        delegate?.buttonsView(buttonsView: self, didTapItemAtIndex: index)
    }
    func popButtons() {
        if let delegate = delegate {
            delegate.buttonsViewWillAppear?(buttonsView: self)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6,
                                       initialSpringVelocity: 0.1,
                                       options: UIViewAnimationOptions.curveLinear,
                                       animations: {
                                        self.cancelButton.transform = CGAffineTransform(translationX: 0, y: -self.totalHeight)
                }, completion: nil)
            
            for index in (0..<delegate.numOfItems(buttonsView: self)) {
                self.bigButtons[index].transform = CGAffineTransform(translationX: 0, y: -self.totalHeight)
                let itemNum = index % delegate.maxNumberOfItemsInRow(buttonsView: self)
                UIView.animate(withDuration: 1, delay: 0.1 * Double(itemNum), usingSpringWithDamping: 0.6,
                                           initialSpringVelocity: 0.1,
                                           options: UIViewAnimationOptions.curveLinear,
                                           animations: {
                                            self.buttons[index].transform = CGAffineTransform(translationX: 0, y: -self.totalHeight)
                    }, completion: nil)
            }
        }
    }
    func dismissButtons() {
        if let delegate = delegate {
            delegate.buttonsViewWillDisappear?(buttonsView: self)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6,
                                       initialSpringVelocity: 0.1,
                                       options: UIViewAnimationOptions.curveLinear,
                                       animations: {
                                        self.cancelButton.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: { (check) in
                    //                    self.hidden = true
            })
            
            for index in (0..<delegate.numOfItems(buttonsView: self)) {
                self.bigButtons[index].transform = CGAffineTransform(translationX: 0, y: 0)
                let itemNum = index % delegate.maxNumberOfItemsInRow(buttonsView: self)
                UIView.animate(withDuration: 1, delay: 0.1 * Double(itemNum), usingSpringWithDamping: 0.6,
                                           initialSpringVelocity: 0.1,
                                           options: UIViewAnimationOptions.curveLinear,
                                           animations: {
                                            self.buttons[index].transform = CGAffineTransform(translationX: 0, y: 0)
                    }, completion: { (check) in
                        //                    self.hidden = true
                })
            }
        }
    }
    func setConstraints() {
        self.overlay.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: self.overlay, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.overlay, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.overlay, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.overlay, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -30 + totalHeight)
        let centerXConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let heightConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        let widthConstraintTwo = NSLayoutConstraint(item: self.cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        self.addConstraints([bottomConstraintTwo, centerXConstraintTwo, heightConstraintTwo, widthConstraintTwo])
    }
    
    func setItemConstrains(itemSpace: CGFloat) {
        for each in overlay.subviews {
            each.removeFromSuperview()
        }
        for index in (0..<delegate!.numOfItems(buttonsView: self)) {
            let rowNum = index / delegate!.maxNumberOfItemsInRow(buttonsView: self)
            let itemNum = index % delegate!.maxNumberOfItemsInRow(buttonsView: self)
            let button = (delegate?.buttonsView(buttonsView: self, itemForIndex: index))!
            buttons.append(button)
            self.addSubview(button)
            let bigButton = UIButton()
            bigButtons.append(bigButton)
            bigButton.backgroundColor = .clear
            self.addSubview(bigButton)
            bigButton.tag = index
            bigButton.addTarget(self, action: #selector(bigButtonHandler), for: .touchUpInside)
            bigButton.translatesAutoresizingMaskIntoConstraints = false
            if delegate!.numOfItems(buttonsView: self) < delegate!.maxNumberOfItemsInRow(buttonsView: self) {
                if delegate!.numOfItems(buttonsView: self) == 1 {
                    let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                    let centerX = NSLayoutConstraint(item: bigButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                    let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                    let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).width)
                    self.addConstraints([bottomConstraint, centerX, heightConstraint, widthConstraint])
                } else {
                    if itemNum == 0 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: sideMargin + delegate!.itemSize(buttonsView: self).width / 2)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                        self.addConstraints([bottomConstraint, centerX, heightConstraint])
                    } else if itemNum == delegate!.numOfItems(buttonsView: self) - 1 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .leading, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .trailing, multiplier: 1, constant: 0)
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -(sideMargin + delegate!.itemSize(buttonsView: self).width / 2))
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, centerX, leadingConstraint, heightConstraint, widthConstraint])
                    } else {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .leading, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .trailing, multiplier: 1, constant: 0)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, leadingConstraint, heightConstraint, widthConstraint])
                    }
                }
            } else {
                if rowNum == 0 {
                    if itemNum == 0 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: sideMargin + delegate!.itemSize(buttonsView: self).width / 2)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                        self.addConstraints([bottomConstraint, centerX, heightConstraint])
                    } else if itemNum == delegate!.maxNumberOfItemsInRow(buttonsView: self) - 1 {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .leading, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .trailing, multiplier: 1, constant: 0)
                        let centerX = NSLayoutConstraint(item: bigButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -(sideMargin + delegate!.itemSize(buttonsView: self).width / 2))
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, centerX, leadingConstraint, heightConstraint, widthConstraint])
                    } else {
                        let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                        let leadingConstraint = NSLayoutConstraint(item: bigButton, attribute: .leading, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .trailing, multiplier: 1, constant: 0)
                        let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                        let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: bigButtons[index - 1], attribute: .width, multiplier: 1, constant: 0)
                        self.addConstraints([bottomConstraint, leadingConstraint, heightConstraint, widthConstraint])
                    }
                } else {
                    let preIndex = index - delegate!.maxNumberOfItemsInRow(buttonsView: self)
                    let bottomConstraint = NSLayoutConstraint(item: bigButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: totalHeight - 70 - CGFloat(totalRowNum - 1 - rowNum) * (spaceBetweenRows + delegate!.itemSize(buttonsView: self).height))
                    let centerX = NSLayoutConstraint(item: bigButton, attribute: .centerX, relatedBy: .equal, toItem: bigButtons[preIndex], attribute: .centerX, multiplier: 1, constant: 0)
                    let heightConstraint = NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).height)
                    let widthConstraint = NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: bigButtons[preIndex], attribute: .width, multiplier: 1, constant: 0)
                    self.addConstraints([bottomConstraint, centerX, heightConstraint, widthConstraint])
                }
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            let bottomConstraintTwo = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: bigButton, attribute: .bottom, multiplier: 1, constant: 0)
            let topConstraintTwo = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: bigButton, attribute: .top, multiplier: 1, constant: 0)
            let centerX = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: bigButton, attribute: .centerX, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: delegate!.itemSize(buttonsView: self).width)
            self.addConstraints([bottomConstraintTwo, topConstraintTwo, centerX, widthConstraint])
        }
    }
    
}

extension YFPopupButtonsView {
    func loadBundleImage(name: String) -> UIImage? {
        let podBundle = Bundle(for: YFPopupButtonsView.self)
        if let url = podBundle.url(forResource: "YFPopupButtons", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
}
