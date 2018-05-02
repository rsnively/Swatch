import Foundation
import SpriteKit

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

extension SKNode {
    func runAndRemove(_ action:SKAction) {
        run(SKAction.sequence([action, SKAction.removeFromParent()]))
    }
}

extension UIColor {
    func isWhite() -> Bool {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        assert(self.getRed(&r, green:&g, blue:&b, alpha:&a))
        return r == 1.0 && g == 1.0 && b == 1.0
    }
    
    var r:CGFloat {
        get {
            var red:CGFloat = 0
            assert(self.getRed(&red, green:nil, blue:nil, alpha:nil))
            return red
        }
    }
    var g:CGFloat {
        get {
            var green:CGFloat = 0
            assert(self.getRed(nil, green:&green, blue:nil, alpha:nil))
            return green
        }
    }
    var b:CGFloat {
        get {
            var blue:CGFloat = 0
            assert(self.getRed(nil, green:nil, blue:&blue, alpha:nil))
            return blue
        }
    }
    var a:CGFloat {
        get {
            var alpha:CGFloat = 0
            assert(self.getRed(nil, green:nil, blue:nil, alpha:&alpha))
            return alpha
        }
    }
}
