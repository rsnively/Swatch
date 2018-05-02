import Foundation
import SpriteKit

class GridNode: SKNode {
    var rows:Int
    var cols:Int
    var colorSquares:[[ColorSquareNode?]] = []
    
    init(numRows:Int, numCols:Int) {
        rows = numRows
        cols = numCols
        
        let chanceNothing:CGFloat = 0.0
        for r in 0 ..< rows {
            colorSquares.append([])
            for _ in 0 ..< cols {
                if random() < chanceNothing {
                    colorSquares[r].append(nil)
                }
                else {
                    colorSquares[r].append(ColorSquareNode(color: UIColor(red: random(), green:random(), blue:random(), alpha:1.0)))
                }
            }
        }
        
        super.init()
        
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                if let colorSquare = colorSquares[r][c] {
                    colorSquare.position = CGPoint(x:CGFloat(c) * ColorSquareNode.squareSize.width,
                                                   y:CGFloat(r) * ColorSquareNode.squareSize.height)
                    addChild(colorSquare)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSquare(atPoint pos:CGPoint) -> ColorSquareNode? {
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                if let colorSquare = colorSquares[r][c] {
                    if colorSquare.contains(pos) {
                        return colorSquare
                    }
                }
            }
        }
        return nil
    }
    
    func removeSquare(_ square:ColorSquareNode) {
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                if let csn = colorSquares[r][c] {
                    if csn == square {
                        csn.runAndRemove(SKAction.fadeOut(withDuration:0.5))
                        colorSquares[r][c] = nil
                    }
                }
            }
        }
    }
}
