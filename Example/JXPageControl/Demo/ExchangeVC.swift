//
//  ExchangeVC.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/7/13.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

class ExchangeVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var `default`: JXPageControlExchange!
    @IBOutlet weak var inactivehollow: JXPageControlExchange!
    @IBOutlet weak var activehollow: JXPageControlExchange!
    @IBOutlet weak var allHollow: JXPageControlExchange!
    
    @IBOutlet weak var toEllipe: JXPageControlExchange!
    @IBOutlet weak var toCircle: JXPageControlExchange!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        `default`.activeColor = .yellow
        inactivehollow.activeColor = .blue
        activehollow.activeColor = .green
        
        allHollow.activeColor = .red
        toEllipe.activeColor = .brown
        toCircle.activeColor = .cyan
        
        toEllipe.numberOfPages = 4 //Main.storyboard is uneditable, please open in source code mode
        toEllipe.columnSpacing = 16
        toEllipe.inactiveSize = CGSize(width: 16, height: 8)
        toEllipe.activeSize = CGSize(width: 56, height: 8)
    }
    
    deinit {
        print("\(#function ) --> \(#file)")
    }
}

extension ExchangeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.x * 1.0 / scrollView.bounds.width
        // 方式一 渐变动画效果（更丝滑）
        `default`.progress = progress
        inactivehollow.progress = progress
        activehollow.progress = progress
        allHollow.progress = progress
        toEllipe.progress = progress
        toCircle.progress = progress
        
        // 方式二 无渐变动画
//        let currentPage = Int(round(progress))
//        `default`.currentPage = currentPage
//        inactivehollow.currentPage = currentPage
//        activehollow.currentPage = currentPage
//        allHollow.currentPage = currentPage
//        toEllipe.currentPage = currentPage
//        toCircle.currentPage = currentPage
    }
}
