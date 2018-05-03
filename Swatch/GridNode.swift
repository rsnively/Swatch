import Foundation
import SpriteKit

enum Direction {
    case up
    case down
    case left
    case right
}

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
            for c in 0 ..< cols {
                if random() < chanceNothing {
                    colorSquares[r].append(nil)
                }
                else {
                    colorSquares[r].append(ColorSquareNode(row:r, col:c, color: UIColor(red: random(), green:random(), blue:random(), alpha:1.0)))
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
    
    func getGridPosition(point:CGPoint) -> (Int, Int) {
        let r = Int(floor(point.y / ColorSquareNode.squareSize.height + 0.5))
        let c = Int(floor(point.x / ColorSquareNode.squareSize.width + 0.5))
        return (r, c)
    }
    
    func getSquare(atPos pos:CGPoint) -> ColorSquareNode? {
        let (r, c) = getGridPosition(point:pos)
        return (0 ..< rows).contains(r) && (0 ..< cols).contains(c) && colorSquares[r][c] != nil && !colorSquares[r][c]!.color.isWhite() ? colorSquares[r][c] : nil
    }
    
    func removeSquare(_ square:ColorSquareNode, shift:Direction) {
        let (removedRow, removedCol) = getGridPosition(point:square.position)
        square.runAndRemove(SKAction.wait(forDuration:1.0))
        
        switch shift {
        case Direction.up:
            for r in stride(from:removedRow, to:0, by:-1){
                colorSquares[r][removedCol] = colorSquares[r-1][removedCol]
                if colorSquares[r][removedCol] == nil || colorSquares[r][removedCol]!.color.isWhite() { return }
                colorSquares[r][removedCol]?.row = r
                colorSquares[r][removedCol]?.slideUp()
            }
            colorSquares[0][removedCol] = nil
        case Direction.down:
            for r in removedRow ..< rows - 1 {
                colorSquares[r][removedCol] = colorSquares[r+1][removedCol]
                if colorSquares[r][removedCol] == nil || colorSquares[r][removedCol]!.color.isWhite() { return }
                colorSquares[r][removedCol]?.row = r
                colorSquares[r][removedCol]?.slideDown()
            }
            colorSquares[rows-1][removedCol] = nil
        case Direction.right:
            for c in stride(from:removedCol, to:0, by:-1){
                colorSquares[removedRow][c] = colorSquares[removedRow][c-1]
                if colorSquares[removedRow][c] == nil || colorSquares[removedRow][c]!.color.isWhite() { return }
                colorSquares[removedRow][c]?.col = c
                colorSquares[removedRow][c]?.slideRight()
            }
            colorSquares[removedRow][0] = nil
        case Direction.left:
            for c in removedCol ..< cols - 1 {
                colorSquares[removedRow][c] = colorSquares[removedRow][c+1]
                if colorSquares[removedRow][c] == nil || colorSquares[removedRow][c]!.color.isWhite() { return }
                colorSquares[removedRow][c]?.col = c
                colorSquares[removedRow][c]?.slideLeft()
            }
            colorSquares[removedRow][cols-1] = nil
        }
    }
    
    func combineSquares(_ a:ColorSquareNode, _ b:ColorSquareNode) -> UIColor {
//        let color = UIColor(red:(a.color.r + b.color.r)/2.0, green:(a.color.g + b.color.g)/2.0, blue:(a.color.b + b.color.b)/2.0, alpha:(a.color.a + b.color.a)/2.0)
        let color = UIColor(red:min(1.0, a.color.r + b.color.r), green:min(1.0, a.color.g + b.color.g), blue:min(1.0, a.color.b + b.color.b), alpha:min(1.0, a.color.a + b.color.a))
        a.changeColor(to:color)
        b.changeColor(to:color)
        
        let (ar, ac) = getGridPosition(point:a.position)
        let (br, bc) = getGridPosition(point:b.position)
        // a on top of b
        if ar == br + 1 {
            removeSquare(b, shift:Direction.down)
        }
        // a below b
        else if ar == br - 1 {
            removeSquare(b, shift:Direction.up)
        }
        // a to right of b
        if ac == bc + 1 {
            removeSquare(b, shift:Direction.left)
        }
        // a to left of b
        else if ac == bc - 1 {
            removeSquare(b, shift:Direction.right)
        }
        return color
    }
}
