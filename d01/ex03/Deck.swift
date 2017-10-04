import Foundation

class Deck : NSObject {
    static let allSpades = Value.allValues.map({ (val) -> Card in
        var returnValue = Card(_color_ : Color.Spades, _value_ : val)
        return (returnValue);
    });
    
    static let allDiamonds = Value.allValues.map({ (val) -> Card in
        var returnValue = Card(_color_ : Color.Diamonds, _value_ : val)
        return (returnValue);
    });
    
    static let allHearts = Value.allValues.map({ (val) -> Card in
        var returnValue = Card(_color_ : Color.Hearts, _value_ : val)
        return (returnValue);
    });
    
    static let allClubs = Value.allValues.map({ (val) -> Card in
        var returnValue = Card(_color_ : Color.Clubs, _value_ : val)
        return (returnValue);
    });
    
    static let allCards = allSpades + allDiamonds + allHearts + allClubs;
}

extension Array {
    mutating func shuffle() {
        if count < 2 {
            if (Int(arc4random_uniform(UInt32(21))) > 10)
            {
                swap(&self[0], &self[1]);
            }
            return ;
        }
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
    
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}
