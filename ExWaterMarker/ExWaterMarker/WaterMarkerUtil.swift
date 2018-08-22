//
//  ImageWaterMarkedUtil.swift
//  FXChat
//
//  Created by muhlenXi on 2018/8/22.
//  Copyright © 2018年 PengZhihao. All rights reserved.
//

import UIKit

public enum WaterMarkedImageType {
    case bbs
    case finance
    case fx110
    case fxchat
    case niu
    
    var markedImage: UIImage? {
        get {
            var image: UIImage? = nil
            switch self {
            case .bbs:
                image = UIImage(named: "bbsMarked")
            case .finance:
                image = UIImage(named: "financeMarked")
            case .fx110:
                image = UIImage(named: "fx110Marked")
            case .fxchat:
                image = UIImage(named: "fxchatMarkerd")
            case .niu:
                image = UIImage(named: "niuMarked")
            }
            return image
        }
    }
}

extension UIImage {
    
    /// 水印方式枚举
    enum WaterMarkMode {
        /// 左上
        case topLeft
        /// 右下
        case topRight
        /// 左下
        case bottomLeft
        /// 右下
        case bottomRight
        /// 平铺
        case tiled
    }
    
    /// 以平铺方式的图片添加水印
    func makeTiledMarkedWithWaterMarkedImageType(type: WaterMarkedImageType)  -> UIImage? {
        if let waterMarkImage = type.markedImage {
            return self.makeWaterMarkedImage(waterMarkImage: waterMarkImage, mode: .tiled, margin: CGPoint.zero, alpha: 0.5)
        } else {
            return nil
        }
    }
    
    /// 添加图片水印
    func makeWaterMarkedImage(waterMarkImage: UIImage, mode: WaterMarkMode = .bottomRight,
                          margin: CGPoint = CGPoint(x: 20, y: 20), alpha:CGFloat = 1.0) -> UIImage? {
        let waterMarkImageWidth = waterMarkImage.size.width
        let waterMarkImageheight = waterMarkImage.size.height
        
        var markedFrames = [CGRect]()
        let imageSize = self.size
        
        switch mode {
        case .topLeft:
            markedFrames.append(CGRect(x: margin.x, y: margin.y, width: waterMarkImageWidth, height: waterMarkImageheight))
        case .topRight:
            markedFrames.append(CGRect(x: imageSize.width - waterMarkImageWidth - margin.x, y: margin.y, width: waterMarkImageWidth, height: waterMarkImageheight))
        case .bottomLeft:
            markedFrames.append(CGRect(x: margin.x, y: imageSize.height - waterMarkImageheight - margin.y, width: waterMarkImageWidth, height: waterMarkImageheight))
        case .bottomRight:
            markedFrames.append(CGRect(x: imageSize.width - waterMarkImageWidth - margin.x, y: imageSize.height - waterMarkImageheight - margin.y, width: waterMarkImageWidth, height: waterMarkImageheight))
        case .tiled:
            for x in 0..<Int(ceil(imageSize.width/waterMarkImageWidth)) {
                for y in 0..<Int(ceil(imageSize.height/waterMarkImageheight)) {
                    markedFrames.append(CGRect(x: waterMarkImageWidth*CGFloat(x), y: waterMarkImageheight*CGFloat(y), width: waterMarkImageWidth, height: waterMarkImageheight))
                }
            }
            break
        }
        
        // 开始给图片添加图片水印
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        for frame in markedFrames {
            waterMarkImage.draw(in: frame, blendMode: .normal, alpha: alpha)
        }
        
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage
    }
}

