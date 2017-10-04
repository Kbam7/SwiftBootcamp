var card1 = Card(col: Color.diamond, val: Value.ace)
var card2 = Card(col: Color.spade, val: Value.ace)

print(card1.isEqual(card2))
print(card1 == card2)
print(!(card1 == card2))
