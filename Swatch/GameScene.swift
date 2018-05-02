import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var grid:GridNode
    var selectedSquare:ColorSquareNode? = nil {
        willSet(newSquare) {
            selectedSquare?.selected = false
        }
        didSet {
            selectedSquare?.selected = true
        }
    }
    
    override init(size:CGSize) {
        let rows = min(10, Int(size.height / ColorSquareNode.squareSize.height))
        let cols = min(10, Int(size.width / ColorSquareNode.squareSize.width))
        grid = GridNode(numRows:rows, numCols:cols)
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        
        grid.position = CGPoint(x:(size.width - ColorSquareNode.squareSize.width * CGFloat(grid.cols)) / 2.0 + ColorSquareNode.squareSize.width / 2.0,
                                y:(size.height - ColorSquareNode.squareSize.height * CGFloat(grid.rows)) / 2.0 + ColorSquareNode.squareSize.height / 2.0)
        addChild(grid)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let newSquare = grid.getSquare(atPos:convert(pos, to: grid)) {
            if let oldSquare = selectedSquare {
                if newSquare.isNeighbor(ofSquare: oldSquare) {
                    selectedSquare = nil
                    grid.combineSquares(oldSquare, newSquare)
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
