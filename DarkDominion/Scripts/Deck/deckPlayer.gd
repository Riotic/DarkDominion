extends Node2D

signal effect
signal monster
signal cardInHand

var cards = {}
var myDeck = {
	"cardToto1" : { "type": "summon", "title": "Toto", "description": "Toto", "image": "res://Assets/Img/ImgCards/basicMonster1.png", "strength": 2},
	"cardPinguin1" : { "type": "summon", "title": "Pinguin", "description": "Je suis un pingouin", "image": "res://Assets/Img/ImgCards/pingouin.jpg", "strength": 1},
	"cardToto2" : { "type": "summon", "title": "Toto", "description": "Toto", "image": "res://Assets/Img/ImgCards/basicMonster1.png", "strength": 2},
	"cardPinguin2" : { "type": "summon", "title": "Pinguin", "description": "Je suis un pingouin", "image": "res://Assets/Img/ImgCards/pingouin.jpg", "strength": 1},
	"cardGold1": {"type": "effect", "title": "Or", "description": "Ca me donne de l'or héhé", "image": "res://Assets/Img/ImgCards/gold.jpg", "effect": "+2--gold"},
	"cardPinguin3" : { "type": "summon", "title": "Pinguin", "description": "Je suis un pingouin", "image": "res://Assets/Img/ImgCards/pingouin.jpg", "strength": 1},
	"cardGold2": {"type": "effect", "title": "Or", "description": "Ca me donne de l'or héhé", "image": "res://Assets/Img/ImgCards/gold.jpg", "effect": "+2--gold"},
	"cardPinguin4" : { "type": "summon", "title": "Pinguin", "description": "Je suis un pingouin", "image": "res://Assets/Img/ImgCards/pingouin.jpg", "strength": 1},
	"cardGold3": {"type": "effect", "title": "Or", "description": "Ca me donne de l'or héhé", "image": "res://Assets/Img/ImgCards/gold.jpg", "effect": "+2--gold"},
	"cardGold4": {"type": "effect", "title": "Or", "description": "Ca me donne de l'or héhé", "image": "res://Assets/Img/ImgCards/gold.jpg", "effect": "+2--gold"}
}
var myDiscard = {}


func displayCards(cardNbr, card):
	cardNbr.texture = load(card.image)
	cardNbr.title = load(card.title)
	cardNbr.description = load(card.description)
# Called when the node enters the scene tree for the first time.

# A factoriser svp
func generateCard():
	var NbrOfCard = (get_children().size() - 1 )
	var ForNameCard = get_children().size()
	var NameForCard = "Card%s"
	var ActualNameForCard = NameForCard % ForNameCard
	var Card = TextureRect.new()
	Card.set_name(ActualNameForCard)
	Card.position.x = 205 + (NbrOfCard * 60)
	Card.position.y = 226
	Card.size.x = 47
	Card.size.y = 68
	Card.texture = load("res://Assets/Img/ImgCards/front.png")
	Card.expand_mode = 1
	add_child(Card)
	var Effect = TextureButton.new()
	var NameForEffect = "Effect-%s"
	var ActualNameForEffect = NameForEffect % ForNameCard
	Effect.set_name(ActualNameForEffect)
	Effect.set_anchors_preset(Control.PRESET_FULL_RECT)
#	Effect.connect("_on_effect", self, ForNameCard)
	Card.add_child(Effect)
	var Monster = TextureButton.new()
	var NameForMonster = "Monster-%s"
	var ActualNameForMonster = NameForMonster % ForNameCard
	Monster.set_name(ActualNameForMonster)
	Monster.set_anchors_preset(Control.PRESET_FULL_RECT)
#	Monster.pressed.connect(self._on_monster)
	Card.add_child(Monster)
	var ImgCard = TextureRect.new()
	ImgCard.set_name("ImgCard")
	ImgCard.size.x = 41
	ImgCard.size.y = 40
	ImgCard.position.x = 3
	ImgCard.position.y = 3
	ImgCard.scale.x = 1
	ImgCard.scale.y = 1
	ImgCard.expand_mode = 1
	Card.add_child(ImgCard)
	var Title = Label.new()
	Title.set_name("Title")
	Title.size.x = 8
	Title.size.y = 8
	Title.position.x = 3
	Title.position.y = 44
	Title.scale.x = 1
	Title.scale.y = 1
	Title.horizontal_alignment =HORIZONTAL_ALIGNMENT_LEFT
	Title.vertical_alignment =VERTICAL_ALIGNMENT_TOP
	Title.add_theme_font_size_override("font_size", 3)
#	print(Title.get_font_name())
	Card.add_child(Title)
	var Description = Label.new()
	Description.set_name("Description")
	Description.size.x = 40
	Description.size.y = 13
	Description.position.x = 3
	Description.position.y = 51
	Description.scale.x = 1
	Description.scale.y = 1
	Description.add_theme_font_size_override("font_size", 3)
	Card.add_child(Description)
	return Card
	
	
func addACardFromDeck(i):
	var Card = generateCard()
	var nameCardEffect = "Effect-%s"
	var ActualNameForEffect = nameCardEffect % i
	var nameMonster = "Monster-%s"
	var ActualNameForMonster = nameMonster % i
	var cardEffect = Card.get_node(ActualNameForEffect)
	var cardMonster = Card.get_node(ActualNameForMonster)
	var PictureCard = Card.get_node("ImgCard")
	var TitleCard = Card.get_node("Title")
	var DescriptionCard = Card.get_node("Description")
	var nbrOfCards = myDeck.keys().size()
	var allKeysDeck = myDeck.keys()
	var titleCard = allKeysDeck[randi_range(0, (nbrOfCards - 1))]
	cards[titleCard] = myDeck[titleCard]
#	Préparation réfléxion défausse
#	myDiscard[cards] = myDeck[cards]
	PictureCard.texture = load(cards[titleCard]["image"])
	TitleCard.text = cards[titleCard]["title"]
	DescriptionCard.text = cards[titleCard]["description"]
	if cards[titleCard]["type"] == "effect":
		cardEffect.visible = true
		cardMonster.visible = false
	if cards[titleCard]["type"] == "summon":
		cardEffect.visible = false
		cardMonster.visible = true
	myDeck.erase(cards)

#func choseRandomCardTurn1():
#	cards.add()

func _ready():
	for i in range(4):
		addACardFromDeck(i+1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_effect_pressed():
#nbrOfCard
	print("Test Effect")
#	print(x)
#	var NameForEffect = "Effect-%s"
#	var ActualNameForEffect = NameForEffect % nbrOfCard
#	print(ActualNameForEffect)
#	print("Hello")
#	var toRemove = get_node(ActualNameForEffect)
#	remove_child(toRemove)
#	var title = get_owner().get_node("Title").text
#	var effect = cards[title].effect
#	emit_signal("effect", effect)
#	var Test = get_children()

func _on_monster_pressed():
	print("Test Monster")
#	print(x)


func _on_effect(x):

	print("Test effect")



func _on_monster(x):
	print("Test monster")

