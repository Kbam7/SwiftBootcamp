import Foundation

var newArray    = [1, 2, 4, 5, 6, 7];
//var deck        = Deck();

print("-----------------------------------  Test shuffle() With Random Array  -----------------------------------");

print("Array  Before  Fn(Shuffle) :: \(newArray)\n");
newArray.shuffle();
print("Array  After   Fn(Shuffle) :: \(newArray)\n");

print("-----------------------------------  Test shuffle() With Deck Of Cards  -----------------------------------");

print("Deck Of Cards Before   Fn(Shuffle) :: \n");
for card in Deck.allCards
{
    print(card);
}

print("Deck Of Cards After   Fn(Shuffle) :: \n");
for card in Deck.allCards.shuffled()
{
    print(card);
}



