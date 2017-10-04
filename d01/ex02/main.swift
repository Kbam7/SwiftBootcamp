var res = Deck.allCards.map({
    (card : Card) in
    print("desc: \(card.description)")
})

print("\nDeck:");
print("\tDeck      Count :: \(Deck.allCards.count) cards");
print("\tSpades    Count :: \(Deck.allSpades.count) cards");
print("\tDiamonds  Count :: \(Deck.allDiamonds.count) cards");
print("\tClubs     Count :: \(Deck.allSpades.count) cards");
print("\tHearts    Count :: \(Deck.allHearts.count) cards");

