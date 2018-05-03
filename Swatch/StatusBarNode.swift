import Foundation
import SpriteKit

class ColorBarNode: SKNode {
    var colorNode:SKSpriteNode
    var maxSize:CGSize
    
    init(color:UIColor, size:CGSize) {
        maxSize = size
        colorNode = SKSpriteNode(texture:nil, color:color, size:size)
        super.init()
        addChild(colorNode)
        
        let border = SKShapeNode(rectOf:size)
        border.strokeColor = UIColor.black
        border.lineWidth = 1.5
        addChild(border)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deplete(by percent:CGFloat) {
        colorNode.size.width = max(0.0, colorNode.size.width - maxSize.width * percent / 100.0)
    }
    
    func fill(by percent:CGFloat) {
        colorNode.size.width = min(maxSize.width, colorNode.size.width + maxSize.width * percent / 100.0)
    }
}

class StatusBarNode: SKNode {
    var redBar:ColorBarNode
    var greenBar:ColorBarNode
    var blueBar:ColorBarNode
    
    init(size:CGSize) {
        let colorBarSize = CGSize(width:size.width * 0.25, height:size.height * 0.8)
        redBar = ColorBarNode(color:UIColor.red, size:colorBarSize)
        greenBar = ColorBarNode(color:UIColor.green, size:colorBarSize)
        blueBar = ColorBarNode(color:UIColor.blue, size:colorBarSize)
        
        super.init()
        
        redBar.position = CGPoint(x:-colorBarSize.width * 1.2 , y:0)
        blueBar.position = CGPoint(x:colorBarSize.width * 1.2 , y:0)
        addChild(redBar)
        addChild(greenBar)
        addChild(blueBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func depleteColors(percent:CGFloat) {
        redBar.deplete(by:percent)
        greenBar.deplete(by:percent)
        blueBar.deplete(by:percent)
    }
    
    func refill(color:UIColor) {
        let fillFactor:CGFloat = 1.5
        redBar.fill(by: color.r * fillFactor)
        greenBar.fill(by: color.g * fillFactor)
        blueBar.fill(by: color.b * fillFactor)
    }
}
