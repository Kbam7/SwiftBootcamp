import Foundation

class Card : NSObject {
    
    
    /* Operator definition */
    
    /* Properties */
    var color       : Color;
    var value       : Value;
    
    /* Class Constuctor */
    init(_color_ : Color, _value_ : Value) {
        self.value = _value_;
        self.color = _color_;
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let castObject = object as? Card {
            return ((self.value == castObject.value) && (self.color == castObject.color));
        }
        return (false);
    }
    
    /* Override Functions */
    func customDescription() -> String {
        return ("(\(self.value.rawValue), \(self.color.rawValue))");
    }
    /* Override */
    override var description: String {
        return (customDescription());
    }
    
    static func ==(_card1_ : Card, _card2_ : Card) -> Bool
    {
        if (_card1_.color.rawValue == _card2_.color.rawValue)
        {
            if (_card1_.value.rawValue == _card2_.value.rawValue)
            {
                return (true);
            }
        }
        return (false);
    }
}

