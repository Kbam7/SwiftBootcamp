import Foundation

//let card7 = Card(_color_ : Color.Hearts, _value_ : Value.Seven);
//print("Card 7:")
//print("\tColor      :: " + card7.color.rawValue);
//print("\tValue      :: " + String(card7.value.rawValue));
//print("\tDiscription :: \(card7)");

//var gameBoard1 = Deck(_sorted_or_mixed_ : true);
var gameBoard1 = Deck(_sorted_or_mixed_ : false);

func exposeDeck () {
    print("\nDeck:");
    print("\tDeck      Count :: \(gameBoard1.cards.count) cards");
    print("\tSpades    Count :: \(gameBoard1.spades.count) cards");
    print("\tDiamonds  Count :: \(gameBoard1.diamonds.count) cards");
    print("\tClubs     Count :: \(gameBoard1.clubs.count) cards");
    print("\tHearts    Count :: \(gameBoard1.hearts.count) cards");
    print("\n");
}

func drawCard (_amount_of_cards_ : Int) {
    if (gameBoard1.cards.count <= 0)
    {
        return ;
    }
    
    if (_amount_of_cards_ > gameBoard1.cards.count)
    {
        print("Drawing the rest of the deck -> \(gameBoard1.cards.count) card(s)");
    }
    else
    {
        print("Drawing \(_amount_of_cards_) card(s)");
    }
    var itterations = _amount_of_cards_
    while (itterations > 0 && gameBoard1.cards.count > 0)
    {
        print("\t\(gameBoard1.draw())");
        itterations -= 1;
    }
}


func foldCard (_folding_card_ : Card) {
    
    print("Folding card \(_folding_card_)");
    gameBoard1.fold(_card_ : _folding_card_);
}

exposeDeck();
drawCard(_amount_of_cards_: 3);
gameBoard1.cards.shuffle();
exposeDeck();
foldCard(_folding_card_: Deck.allCards.first!);
drawCard(_amount_of_cards_: 3);
drawCard(_amount_of_cards_: 3);
drawCard(_amount_of_cards_: 3);
exposeDeck();

