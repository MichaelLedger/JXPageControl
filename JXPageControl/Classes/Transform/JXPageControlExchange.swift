//
//  JXPageControlExchange.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


@IBDesignable open class JXPageControlExchange: JXPageControlBase {

    // MARK: - -------------------------- Custom property list --------------------------

    private var allLayerFrames: [CGRect] = []
    
//    private var inactiveOriginFrame: [CGRect] = []
    
    // MARK: - -------------------------- Update tht data --------------------------

    override func updateProgress(_ progress: CGFloat) {
        guard progress >= 0 ,
            progress <= CGFloat(numberOfPages - 1)
            else { return }
        
        let leftIndex = Int(floor(progress))
        currentIndex = leftIndex
        let rightIndex = leftIndex + 1 > numberOfPages - 1 ? leftIndex : leftIndex + 1
        
        if leftIndex == rightIndex {
            
            CATransaction.setDisableActions(true)
            CATransaction.begin()
//            CATransaction.setCompletionBlock { [weak self] in
//                self?.currentIndex = leftIndex
//            }
            
//            let marginX: CGFloat = maxIndicatorSize.width + columnSpacing
//            
//            // 活跃点布局
//            let activeLayerX = (maxIndicatorSize.width - activeSize.width) * 0.5 + floor(progress) * marginX
//            activeLayer?.frame = CGRect(x: activeLayerX,
//                                        y: activeLayer?.frame.minY ?? 0,
//                                        width: activeSize.width,
//                                        height: activeSize.height)
//            
//            // 不活跃点布局
//            for index in 0 ..< numberOfPages - 1 {
//
//                var layerFrame: CGRect = inactiveOriginFrame[index]
//                let layer = inactiveLayer[index]
//
//                if index < Int(progress) {
//                    layerFrame.origin.x -=  marginX
//                    layer.frame = layerFrame
//                }else if index > Int(progress) {
//                    layer.frame = layerFrame
//                }
//            }
            
            recaluculateAllLayerFrames(progress: progress)
            layoutInactiveIndicators()
            layoutActiveIndicator()
            
            CATransaction.commit()
        } else {
            CATransaction.setDisableActions(true)
            CATransaction.begin()
//            CATransaction.setCompletionBlock { [weak self] in
//                self?.currentIndex = leftIndex
//            }
            
//            let marginX: CGFloat = maxIndicatorSize.width + columnSpacing
//            
//            // 活跃点布局
//            let activeLayerX = (maxIndicatorSize.width - activeSize.width) * 0.5 + progress * marginX
//            activeLayer?.frame = CGRect(x: activeLayerX,
//                                        y: activeLayer?.frame.minY ?? 0,
//                                        width: activeSize.width,
//                                        height: activeSize.height)
//            
//            // 不活跃点布局
//            for index in 0 ..< numberOfPages - 1 {
//                
//                var layerFrame: CGRect = inactiveOriginFrame[index]
//                let layer = inactiveLayer[index]
//                
//                if index < Int(progress) {
//                    layerFrame.origin.x -=  marginX
//                    layer.frame = layerFrame
//                }else if index > Int(progress) {
//                    layer.frame = layerFrame
//                }else {
//                    let leftScare = progress - floor(progress)
//                    layerFrame.origin.x =  layerFrame.origin.x - leftScare * marginX
//                    layer.frame = layerFrame
//                }
//            }
            
            recaluculateAllLayerFrames(progress: progress)
            layoutInactiveIndicators()
            layoutActiveIndicator()
            
            CATransaction.commit()
        }
    }
    
    override func updateCurrentPage(_ pageIndex: Int) {
        guard pageIndex >= 0 ,
            pageIndex <= numberOfPages - 1,
            pageIndex != currentIndex
        else {
            return
        }
        currentIndex = pageIndex
        
        reloadLayout()//test
        
//        let marginX: CGFloat = maxIndicatorSize.width + columnSpacing
        
        // 活跃点布局
//        let activeLayerX = (maxIndicatorSize.width - activeSize.width) * 0.5 + CGFloat(pageIndex) * marginX
//        activeLayer?.frame = CGRect(x: activeLayerX,
//                                    y: activeLayer?.frame.minY ?? 0,
//                                    width: activeSize.width,
//                                    height: activeSize.height)
    }
    
    override func inactiveHollowLayout() {
        if isInactiveHollow {
            inactiveLayer.forEach { (layer) in
                layer.backgroundColor = UIColor.clear.cgColor
                layer.borderColor = inactiveColor.cgColor
                layer.borderWidth = 1
            }
        }else {
            inactiveLayer.forEach { (layer) in
                layer.backgroundColor = inactiveColor.cgColor
                layer.borderWidth = 0
            }
        }
    }
    
    override func activeHollowLayout() {
        if isActiveHollow {
            activeLayer?.backgroundColor = UIColor.clear.cgColor
            activeLayer?.borderColor = activeColor.cgColor
            activeLayer?.borderWidth = 1
        }else {
            activeLayer?.backgroundColor = activeColor.cgColor
            activeLayer?.borderWidth = 0
        }
    }
    
    // MARK: - -------------------------- Reset --------------------------
    
    override func resetInactiveLayer() {
        // clear data
        inactiveLayer.forEach() { $0.removeFromSuperlayer() }
        inactiveLayer = [CALayer]()
//        inactiveOriginFrame = []
        // set new layers
        for _ in 0 ..< numberOfPages - 1 {
            let layer = CALayer()
            contentView.layer.addSublayer(layer)
            inactiveLayer.append(layer)
        }
    }
    
    override func resetActiveLayer() {
        
        activeLayer?.removeFromSuperlayer()
        activeLayer = CALayer()
        contentView.layer.addSublayer(activeLayer!)
    }
    
    // MARK: - -------------------------- Layout --------------------------
    
    
    override func layoutActiveIndicator() {
//        if let activeLayer = activeLayer  {
//            let x = (maxIndicatorSize.width - activeSize.width) * 0.5
//            let y = (maxIndicatorSize.height - activeSize.height) * 0.5
//            activeLayer.frame = CGRect(x: x,
//                                        y: y,
//                                        width: activeSize.width,
//                                        height: activeSize.height)
//            if activeLayer.frame.width > activeLayer.frame.height {
//                activeLayer.cornerRadius = activeLayer.frame.height*0.5
//            }else {
//                activeLayer.cornerRadius = activeLayer.frame.width*0.5
//            }
//            activeHollowLayout()
//        }
        
//        recaluculateAllLayerFrames()
        
        if let activeLayer = activeLayer  {
            let layerFrame: CGRect = allLayerFrames[currentIndex]
            // 活跃点布局
            activeLayer.frame = layerFrame
            if activeLayer.frame.width > activeLayer.frame.height {
                activeLayer.cornerRadius = activeLayer.frame.height*0.5
            }else {
                activeLayer.cornerRadius = activeLayer.frame.width*0.5
            }
        }
        activeHollowLayout()
    }
    
    override func layoutInactiveIndicators() {
//        inactiveOriginFrame = []
//        let x = (maxIndicatorSize.width - inactiveSize.width) * 0.5
//        let y = (maxIndicatorSize.height - inactiveSize.height) * 0.5
//        var layerFrame = CGRect(x: x + maxIndicatorSize.width + columnSpacing,
//                                y: y,
//                                width: inactiveSize.width,
//                                height: inactiveSize.height)
//        inactiveLayer.forEach() { layer in
//            layer.frame = layerFrame
//            inactiveOriginFrame.append(layerFrame)
//            if layer.frame.width > layer.frame.height {
//                layer.cornerRadius = layer.frame.height*0.5
//            }else {
//                layer.cornerRadius = layer.frame.width*0.5
//            }
//            layerFrame.origin.x +=  maxIndicatorSize.width + columnSpacing
//        }
//        inactiveHollowLayout()
        
        var inactiveLayerIndex: Int = 0
        for index in 0 ..< numberOfPages {
            let layerFrame: CGRect = allLayerFrames[index]
            if index != currentIndex {// 不活跃点布局
                let layer = inactiveLayer[inactiveLayerIndex]
                layer.frame = layerFrame
                if layer.frame.width > layer.frame.height {
                    layer.cornerRadius = layer.frame.height*0.5
                }else {
                    layer.cornerRadius = layer.frame.width*0.5
                }
                inactiveLayerIndex += 1
            }
        }
        inactiveHollowLayout()
    }
    
    override func recaluculateAllLayerFrames() {
        allLayerFrames = []
        var x: CGFloat = 0
        let y = (maxIndicatorSize.height - inactiveSize.height) * 0.5
        var layerW: CGFloat = 0
        var layerH: CGFloat = 0
        for i in 0..<numberOfPages {
            layerW = i == currentIndex ? activeSize.width : inactiveSize.width
            layerH = i == currentIndex ? activeSize.height : inactiveSize.height
            let layerFrame = CGRect(x: x,
                                    y: y,
                                    width: layerW,
                                    height: layerH)
            allLayerFrames.append(layerFrame)
            x += layerW + columnSpacing
        }
    }
    
    override func recaluculateAllLayerFrames(progress: CGFloat) {
        allLayerFrames = []
        var x: CGFloat = 0
        let y = (maxIndicatorSize.height - inactiveSize.height) * 0.5
        var layerW: CGFloat = 0
        var layerH: CGFloat = 0
        let current: CGFloat = CGFloat(currentIndex)
        var forwardIndex: Int = currentIndex
        if progress > current && currentIndex < numberOfPages - 1 {
            forwardIndex = Int(current + 1)
        } else if progress < current && current > 0 {
            forwardIndex = Int(current - 1)
        }
        for i in 0..<numberOfPages {
            layerW = i == currentIndex ? activeSize.width : inactiveSize.width
            layerH = i == currentIndex ? activeSize.height : inactiveSize.height
            
            var layerFrame = CGRect(x: x,
                                    y: y,
                                    width: layerW,
                                    height: layerH)
            if i == currentIndex {
                layerFrame.origin.x += (progress - CGFloat(currentIndex)) * (inactiveSize.width + columnSpacing)
            } else if i == forwardIndex {
                layerFrame.origin.x -= (progress - CGFloat(currentIndex)) * (activeSize.width + columnSpacing)
            }
            allLayerFrames.append(layerFrame)
            x += layerW + columnSpacing
        }
    }
}
