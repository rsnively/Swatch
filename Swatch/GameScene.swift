import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var grid = GridNode(numRows:10, numCols:10)
    var selectedSquare:ColorSquareNode? = nil {
        willSet(newSquare) {
            selectedSquare?.selected = false
        }
        didSet {
            selectedSquare?.selected = true
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        
        grid.position = CGPoint(x:(size.width - ColorSquareNode.squareSize.width * CGFloat(grid.cols)) / 2.0 + ColorSquareNode.squareSize.width / 2.0,
                                y:(size.height - ColorSquareNode.squareSize.height * CGFloat(grid.rows)) / 2.0 + ColorSquareNode.squareSize.height / 2.0)
        addChild(grid)
    }
    
    func mix(a:ColorSquareNode, b:ColorSquareNode) {
        let color = UIColor(red:(a.color.r + b.color.r)/2.0, green:(a.color.g + b.color.g)/2.0, blue:(a.color.b + b.color.b)/2.0, alpha:(a.color.a + b.color.a)/2.0)
//        let color = UIColor(red:min(a.color.r+b.color.r, 1.0), green:min(a.color.g+b.color.g, 1.0), blue:min(a.color.b+b.color.b, 1.0), alpha:min(a.color.a+b.color.a, 1.0))
        a.color = color
        b.color = color
        
        if color.isWhite() {
            selectedSquare = nil
            grid.removeSquare(a)
            grid.removeSquare(b)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let newSquare = grid.getSquare(atPoint:convert(pos, to: grid)) {
            if let oldSquare = selectedSquare {
                if newSquare.isNeighbor(ofSquare: oldSquare) {
                    mix(a:oldSquare, b:newSquare)
                    selectedSquare = nil
                }
                else {
                    selectedSquare = newSquare
                }
            }
            else {
                selectedSquare = newSquare
            }
        }
        else {
            selectedSquare = nil
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
