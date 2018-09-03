# ExploreWaterMarker
在一些项目中，有时候需要给图片添加水印，比如分享出去的信息一般会附带相应 App 的信息。那怎样给 App 添加水印呢？

通常，水印一般是一张半透明的图片，对于要添加水印的原图，我们可以通过 draw 绘图的方式将水印绘制到原图从而生成一个新的图片。

为了友好控制添加水印的模式，我们可以声明一个枚举，常见的水印填充方式无外乎，左上角、左下角、右上角、右下角和平铺样式。

给 UIImage 添加绘制水印的方法，我们就可以很方便的生成带水印的图片，如：

```swift
let car = UIImage(named: "car")
self.imageView1.image = car?.makeWaterMarkedImage(waterMarkImage: UIImage(named: "bbsMarked")!, mode: .topLeft)
```

添加水印的详细参考代码如下：

```swift
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
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        for frame in markedFrames {
            waterMarkImage.draw(in: frame, blendMode: .normal, alpha: alpha)
        }
        
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage
    }
}
```

*如果有不对的地方欢迎指正！谢谢！*