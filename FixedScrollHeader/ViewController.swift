//
//  ViewController.swift
//  FixedScrollHeader
//
//  Created by SatoshiNoguchi on 2018/07/30.
//  Copyright © 2018年 SatoshiNoguchi. All rights reserved.
//

import UIKit

protocol HeaderScrollDelegate {
    func scrolled(contentOffset: CGFloat)
}

class ViewController: UIViewController {

    @IBOutlet weak var headerScrollView: HeaderScrollView!
    @IBOutlet weak var childScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// ヘッダー載せる領域作成
        childScrollView.contentInset = UIEdgeInsets(top: headerScrollView.frame.height, left: 0, bottom: 0, right: 0)
        childScrollView.contentOffset.y = headerScrollView.frame.height
        childScrollView.delegate = self
        
        /// インディケーターをヘッダー下に移動
        childScrollView.scrollIndicatorInsets.top = headerScrollView.frame.height
        headerScrollView.headerScrollDeletate = self

        /// 上下にスクロール可能にする
        headerScrollView.contentInset.top = 200
        headerScrollView.contentInset.bottom = 200
        headerScrollView.delegate = headerScrollView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        headerScrollView.contentOffset.y = 0
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
        scrollView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: scrollView.contentOffset.y / 10000, alpha: 1.0)
        
        let headerHeight = headerScrollView.frame.height
        let contentOffset = scrollView.contentOffset.y
        
        ///  contentOffset < -300 : 動かさない(ヘッダー大きい版)
        ///  -300 < contentOffset < 0 : ヘッダーを移動
        /// 0 < contentOffset : ヘッダー小さい版
        if contentOffset < -headerHeight {
            scrollView.contentOffset.y = -300
            headerScrollView.frame.origin.y = 0
        } else if -headerHeight <= contentOffset && contentOffset < 0 {
            headerScrollView.frame.origin.y = -headerHeight - contentOffset
            childScrollView.scrollIndicatorInsets.top = headerScrollView.frame.height - headerScrollView.frame.origin.y

        } else if 0 < contentOffset {
            headerScrollView.frame.origin.y = -200
        }

    }
    
}

extension ViewController: HeaderScrollDelegate {
    
    func scrolled(contentOffset: CGFloat) {
        print(contentOffset)

        headerScrollView.contentOffset.y = 0
        childScrollView.contentOffset.y += contentOffset
    }
    
}
