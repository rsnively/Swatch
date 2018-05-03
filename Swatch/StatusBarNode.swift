import Foundation
import SpriteKit

class ColorBarNode: SKNode {
    var colorNode:SKSpriteNode
    
    init(color:UIColor, size:CGSize) {
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
}
