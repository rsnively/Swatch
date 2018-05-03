import Foundation
import SpriteKit

class ColorSquareNode: SKSpriteNode {
    static var squareSize = CGSize(width:75, height:75)
    var row:Int
    var col:Int
    
    private var slideDuration = 0.5
    
    init(row:Int, col:Int, color:UIColor) {
        self.row = row
        self.col = col
        super.init(texture:nil, color:color, size:ColorSquareNode.squareSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isNeighbor(ofSquare other:ColorSquareNode) -> Bool {
        let rowDiff = abs(other.row - row)
        let colDiff = abs(other.col - col)
        return rowDiff + colDiff == 1
    }
    
    func changeColor(to color:UIColor) {
        run(SKAction.sequence([
            SKAction.colorize(with:color, colorBlendFactor:1.0, duration:slideDuration/2.0),
            SKAction.run{
                if self.color.isWhite() {
                    self.color = UIColor.white
                }
            }]));
    }
    
    func slideUp() {
        run(SKAction.moveBy(x:0, y:ColorSquareNode.squareSize.height, duration:slideDuration))
    }
    
    func slideDown() {
        run(SKAction.moveBy(x:0, y:-ColorSquareNode.squareSize.height, duration:slideDuration))
    }
    
    func slideLeft() {
        run(SKAction.moveBy(x:-ColorSquareNode.squareSize.width, y:0, duration:slideDuration))
    }
    
    func slideRight() {
        run(SKAction.moveBy(x:ColorSquareNode.squareSize.width, y:0, duration:slideDuration))
    }
}
