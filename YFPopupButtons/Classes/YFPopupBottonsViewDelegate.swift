//
//  YFPopupBottonsViewDelegate.swift
//  YFPopupButtons
//
//  Created by Yangfan Liu on 3/8/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

@objc public protocol YFPopupBottonsViewDelegate: class {
    func numOfItems(buttonsView: YFPopupButtonsView) -> Int
    func maxNumberOfItemsInRow(buttonsView: YFPopupButtonsView) -> Int
    func itemSize(buttonsView: YFPopupButtonsView) -> CGSize
    func buttonsView(buttonsView: YFPopupButtonsView, itemForIndex index: Int) -> YFPopupbotton
    func buttonsView(buttonsView: YFPopupButtonsView, didTapItemAtIndex index: Int)
    @objc optional func sideMargin(buttonsView: YFPopupButtonsView) -> CGFloat
    @objc optional func spaceBetweenRows(buttonsView: YFPopupButtonsView) -> CGFloat
    @objc optional func buttonsViewWillDisappear(buttonsView: YFPopupButtonsView)
    @objc optional func buttonsViewWillAppear(buttonsView: YFPopupButtonsView)
}
