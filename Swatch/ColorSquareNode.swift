import Foundation
import SpriteKit

class ColorSquareNode: SKSpriteNode {
    static let squareSize = CGSize(width:75, height:75)
    var selected = false {
        didSet {
            if selected {
                let duration = 0.5
                run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration:duration), SKAction.fadeIn(withDuration:duration)])))
            }
            else {
                removeAllActions()
                alpha = 1.0
            }
        }
    }
    
    init(color:UIColor) {
        super.init(texture:nil, color:color, size:ColorSquareNode.squareSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isNeighbor(ofSquare other:ColorSquareNode) -> Bool {
        return other != self && (other.position - self.position).length() <= ColorSquareNode.squareSize.width
    }
}
