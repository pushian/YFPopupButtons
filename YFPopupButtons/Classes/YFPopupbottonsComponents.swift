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
        t.backgroundColor = .clear
        t.clipsToBounds = true
        return t
    }()
    
    public var contentTitle: UILabel! = {
        let t = UILabel()
        t.numberOfLines = 0
        t.textAlignment = .center
        t.textColor = .white
        return t
    }()
    
    public init(contentImage: UIImage, title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
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
        let topConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: self.contentImageView, attribute: .height, relatedBy: .equal, toItem: self.contentImageView, attribute: .width, multiplier: 1, constant: 0)
        self.addConstraints([topConstraint, heightConstraint, leftConstraint, rightConstraint])
        
        self.contentTitle.translatesAutoresizingMaskIntoConstraints = false
        let topConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .top, relatedBy: .equal, toItem: self.contentImageView, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraintTwo = NSLayoutConstraint(item: self.contentTitle, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        self.addConstraints([topConstraintTwo, bottomConstraintTwo, leftConstraintTwo, rightConstraintTwo])
    }
}
