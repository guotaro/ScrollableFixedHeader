//
//  HeaderScrollView.swift
//  FixedScrollHeader
//
//  Created by SatoshiNoguchi on 2018/07/30.
//  Copyright © 2018年 SatoshiNoguchi. All rights reserved.
//

import Foundation
import UIKit

class HeaderScrollView: UIScrollView {
    var headerScrollDeletate: HeaderScrollDelegate?    
}

extension HeaderScrollView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerScrollDeletate?.scrolled(contentOffset: scrollView.contentOffset.y)
    }
}

