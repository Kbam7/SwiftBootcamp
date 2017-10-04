import Foundation

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({
        (val : Value) -> Card in
        return (Card(col : Color.spade, val : val));
    });
    
    static let allDiamonds : [Card] = Value.allValues.map({
        (val : Value) -> Card in
        return (Card(col : Color.diamond, val : val));
    });
    
    static let allHearts : [Card] = Value.allValues.map({
        (val : Value) -> Card in
        return (Card(col : Color.heart, val : val));
    });
    
    static let allClubs : [Card] = Value.allValues.map({
        (val : Value) -> Card in
        return (Card(col : Color.club, val : val));
    });
    
    static let allCards = allSpades + allDiamonds + allHearts + allClubs;
}
