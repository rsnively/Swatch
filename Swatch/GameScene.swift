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
        var ar:CGFloat = 0
        var ag:CGFloat = 0
        var ab:CGFloat = 0
        var aa:CGFloat = 0
        a.color.getRed(&ar, green:&ag, blue:&ab, alpha:&aa)
        var br:CGFloat = 0
        var bg:CGFloat = 0
        var bb:CGFloat = 0
        var ba:CGFloat = 0
        assert(b.color.getRed(&br, green:&bg, blue:&bb, alpha:&ba))
        let color = UIColor(red:(ar + br)/2.0, green:(ag + bg)/2.0, blue:(ab + bb)/2.0, alpha:(aa + ba)/2.0)
//        let color = UIColor(red:min(ar+br, 1.0), green:min(ag+bg, 1.0), blue:min(ab+bb, 1.0), alpha:min(aa+ba, 1.0))
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
