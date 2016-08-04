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
    optional func sideMargin(buttonsView: YFPopupButtonsView) -> CGFloat
    optional func spaceBetweenRows(buttonsView: YFPopupButtonsView) -> CGFloat
    optional func buttonsViewWillDisappear(buttonsView: YFPopupButtonsView)
    optional func buttonsViewWillAppear(buttonsView: YFPopupButtonsView)
}
