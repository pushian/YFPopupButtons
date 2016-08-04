//
//  YFPopupbottonsComponents.swift
//  YFPopupButtons
//
//  Created by Yangfan Liu on 3/8/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFPopupbotton: UIView {
    public var contentImageView: UIImageView! = {
        let t = UIImageView()
        t.backgroundColor = .clearColor()
        t.clipsToBounds = true
        return t
    }()
    
    public var contentTitle: UILabel! = {
        let t = UILabel()
        t.numberOfLines = 0
        t.textAlignment = .Center
        t.textColor = .whiteColor()
        return t
    }()
    
    public init(contentImage: UIImage, title: String) {
        super.init(frame: CGRectZero)
        addSubview(contentImageView)
        addSubview(contentTitle)
        self.contentImageView.image = contentImage
        self.contentTitle.text = title
        self.removeConstraints(self.constraints)
        setConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.contentImageView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .Height, relatedBy: .Equal, toItem: self.contentImageView, attribute: .Width, multiplier: 1, constant: 0)
        self.addConstraints([topConstraint, heightConstraint, leftConstraint, rightConstraint])
        
        self.contentTitle.translatesAutoresizingMaskIntoConstraints = false
        let topConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .Top, relatedBy: .Equal, toItem: self.contentImageView, attribute: .Bottom, multiplier: 1, constant: 0)
        let bottomConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        let leftConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0)
        let rightConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0)
        self.addConstraints([topConstraintTwo, bottomConstraintTwo, leftConstraintTwo, rightConstraintTwo])
    }
}
