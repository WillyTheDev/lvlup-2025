# Manage the card stack of the game
class_name CardsManager

static var _cardStack: Array[Card];

static func pushCard(card: Card):
	CardsManager._cardStack.push_back(card);
	
static func popCard():
	return CardsManager._cardStack.pop_back();
 	
static func getCurrentCard():
	return CardsManager._cardStack.back();
	
static func clearStack():
	CardsManager._cardStack.clear();
