import Foundation


class Deck : NSObject {
    
    /* Properties */
    static let allSpades    : [Card] = Value.allValues.map(
        {
            Card(_color_    : Color.Spades, _value_ :$0)
        });
    static let allHearts    : [Card] = Value.allValues.map(
        {
            Card(_color_    : Color.Hearts, _value_ :$0)
    });
    static let allClubs     : [Card] = Value.allValues.map(
        {
            Card(_color_    : Color.Clubs, _value_ :$0)
    });
    static let allDiamonds  : [Card] = Value.allValues.map(
        {
            Card(_color_    : Color.Diamonds, _value_ :$0)
    });
    static let allCards     = allSpades + allDiamonds + allHearts + allClubs;
    var cards       : [Card]    = allCards;
    var clubs       : [Card]    = allClubs;
    var diamonds    : [Card]    = allDiamonds;
    var hearts      : [Card]    = allHearts;
    var spades      : [Card]    = allSpades;
    var discard     : [Card]    = [];
    var outs        : [Card]    = [];
    
    
    /* Class constructor */
    init(_sorted_or_mixed_  : Bool) {
        if (_sorted_or_mixed_)
        {
            if (self.cards.count > 1)
            {
                self.cards.sort{$0.value.rawValue < $1.value.rawValue};
            }
        }
        else
        {
            self.cards.shuffle();
        }
    }
    
    
    /* Methodes */
    func draw () -> Card? {
        if (cards.count > 0)
        {
            let card : Card = cards.removeFirst();
            outs.append(card);
            
            hearts = hearts.filter { $0 != card };
            diamonds = diamonds.filter { $0 != card };
            spades = spades.filter { $0 != card };
            clubs = clubs.filter { $0 != card };
            
            return (card);
        }
        return (nil);
    }
    
    func fold (_card_ : Card) {
        if (cards.contains(_card_))
        {
            discard.append(_card_);
        }
    }
    
    /* Overrides */
    override var description: String {
        return ("\(self.cards)");
    }
    
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
