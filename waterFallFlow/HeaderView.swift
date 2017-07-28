//
//  HeaderView.swift
//  waterFallFlow
//
//  Created by yu243e on 2017/7/27.
//  Copyright © 2017年 yu243e. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    var headLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headLabel = UILabel()
        headLabel?.frame = CGRect(x: 8, y: 0, width: UIScreen.main.bounds.width - 16, height: 40)
        headLabel?.backgroundColor = UIColor.yellow
        self.addSubview(headLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
