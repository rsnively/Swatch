import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var grid:GridNode
    var statusBar:StatusBarNode
    var selectedSquare:ColorSquareNode? = nil
    
    override init(size:CGSize) {
        let rows = Int(size.height / ColorSquareNode.squareSize.height)
        let cols = Int(size.width / ColorSquareNode.squareSize.width)
        ColorSquareNode.squareSize = CGSize(width: size.width / CGFloat(cols), height:size.height / CGFloat(rows))
        grid = GridNode(numRows:rows-1, numCols:cols)
        statusBar = StatusBarNode(size:CGSize(width:size.width, height:ColorSquareNode.squareSize.height))
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        
        grid.position = CGPoint(x:(size.width - ColorSquareNode.squareSize.width * CGFloat(grid.cols)) / 2.0 + ColorSquareNode.squareSize.width / 2.0,
                                y:(size.height - ColorSquareNode.squareSize.height * CGFloat(grid.rows)) / 2.0)
        addChild(grid)
        
        statusBar.position = CGPoint(x:size.width / 2.0, y:size.height - ColorSquareNode.squareSize.height / 2.0)
        addChild(statusBar)
        run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration:0.05), SKAction.run { self.statusBar.depleteColors(percent:0.1) }])))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        selectedSquare = grid.getSquare(atPos:convert(pos, to: grid))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let newSquare = grid.getSquare(atPos:convert(pos, to: grid)) {
            if let oldSquare = selectedSquare {
                if (newSquare.isNeighbor(ofSquare: oldSquare)) {
                    selectedSquare = nil
                    statusBar.refill(color: grid.combineSquares(oldSquare, newSquare))
                }
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        selectedSquare = nil
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
