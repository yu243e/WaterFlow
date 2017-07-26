//
//  WaterFlowViewLayout.swift
//  waterFallFlow
//
//  Created by yu243e on 2017/7/25.
//  Copyright © 2017年 yu243e. All rights reserved.
//

import UIKit
protocol WaterFlowViewLayoutDelegate: NSObjectProtocol {
    func waterFlowViewLayout(waterFlowViewLayout: WaterFlowViewLayout, heightForWidth: CGFloat, atIndexPath: IndexPath) -> CGFloat
}
class WaterFlowViewLayout: UICollectionViewLayout {

    weak var delegate: WaterFlowViewLayoutDelegate?
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    var maxYDict = [Int: CGFloat]()
    
    static var margin: CGFloat = 8
    
    var sectionInsert = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    var columnMargin: CGFloat = margin
    var rowMargin: CGFloat = margin
    
    var column = 4
    
    var maxY: CGFloat = 0
    
    var columnWidth: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        for key in 0..<column {
            maxYDict[key] = 0
        }
        layoutAttributes.removeAll()
        maxY = 0
        columnWidth = 0
        
        columnWidth = (UIScreen.main.bounds.width - sectionInsert.left - sectionInsert.right - (CGFloat(column) - 1) * columnMargin) / CGFloat(column)
        
        let number = collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0..<number {
            let layoutAttr = layoutAttributesForItem(at: IndexPath(item: i, section: 0))!
            layoutAttributes.append(layoutAttr)
        }
        calcMaxY()
    }
    func calcMaxY() {
        var maxYColumn = 0
        
        for (key, value) in maxYDict {
            if value > maxYDict[maxYColumn]! {
                maxYColumn = key
            }
        }
        
        maxY = maxYDict[maxYColumn]! + sectionInsert.bottom
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: maxY)
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let height = delegate!.waterFlowViewLayout(waterFlowViewLayout: self, heightForWidth: columnWidth, atIndexPath: indexPath)
        var minYColumn = 0
        for(key,value) in maxYDict {
            if value < maxYDict[minYColumn]! {
                minYColumn = key
            }
        }
        let x = sectionInsert.left + CGFloat(minYColumn) * (columnWidth + columnMargin)
        let y: CGFloat
        if maxYDict[minYColumn] == 0 {
            y = sectionInsert.top
        } else {
            y = maxYDict[minYColumn]! + rowMargin
        }
        let frame = CGRect(x: x, y: y, width: columnWidth, height: height)
        maxYDict[minYColumn] = frame.maxY
        let layoutAttr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        layoutAttr.frame = frame
        return layoutAttr
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}
