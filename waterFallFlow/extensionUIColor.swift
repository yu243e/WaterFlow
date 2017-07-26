//
//  TableViewCell.swift
//  waterFallFlow
//
//  Created by yu243e on 2017/7/25.
//  Copyright © 2017年 yu243e. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
    }
    class func randomValue() -> CGFloat {
        return CGFloat(arc4random_uniform(256))/255
    }
}
