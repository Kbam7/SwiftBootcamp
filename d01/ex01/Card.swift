import Foundation

class Card : NSObject
{
    var color : Color;
    var value : Value;
    
    init(col: Color, val : Value)
    {
        // "self" is basically "this", you can have in inluded or not
        self.color = col
        value = val
    }
    
    override var description: String
    {
        return "\(value) of \(color)"
    }
    
    
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return color == object.color
        }
        else {
            return false
        }
    }
    
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.isEqual(rhs)
    }
    
}
