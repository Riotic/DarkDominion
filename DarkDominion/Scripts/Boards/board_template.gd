extends Node2D

var actionsAvailable = [ "drawMaliceDeck", "attack", "summon", "discard", "playEventCard" ]
var J1dict = { "win": false, "turn": false, "actions": [], "countActions": [0,0,0,0,0], "gold": 10 }
var J2dict = { "win": false, "turn": false, "actions": [], "countActions": [0,0,0,0,0], "gold": 10 }
var turnSeconds : int = 0
var player = 1

# Chemin des nodes board_template
var boardSideJ1 = 'BoardRect/OrganiseBoard/OrganisePlayer1/Organise2Player1'
var boardSideJ2 = 'BoardRect/OrganiseBoard/OrganisePlayer2/Organise2Player2'
var goldDisplay = '/CoinsDisplay/NumberOfCoins/DisplayNumber'
var profilePic = '/PlayerProfile/PlayerPicture'
var profilePicShine = '/PlayerProfile/PlayerPictureTurn'
var actionDisplay = '/ActionsDisplay/DisplayActions/'


func displayPictureShiny(pictureToHide1, pictureToDisplay1, pictureToHide2, pictureToDisplay2):
	pictureToHide1.visible = false
	pictureToDisplay1.visible = true
	pictureToHide2.visible = false
	pictureToDisplay2.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(boardSideJ1+goldDisplay).text = str(J1dict.gold)
	get_node(boardSideJ2+goldDisplay).text = str(J2dict.gold)
	$MusicBackground.play()
	$TimerHeadOrTail.start()
	var head_or_tail = $HeadOrTail/ContainerHeadOrTail/AnimatedSprite2D.sprite_frames.get_animation_names()
	var random = head_or_tail[randi() % head_or_tail.size()]
	$HeadOrTail/ContainerHeadOrTail/AnimatedSprite2D.play(random)
	if random == "head":
		$HeadOrTail/ContainerHeadOrTail/Player1Chose.visible = false
		# variable J1dict.turn a modifier pour la logique d'un choix du joueur sur qui commence 
		J2dict.turn = true
		player = 2
		displayPictureShiny(get_node(boardSideJ1+profilePicShine), get_node(boardSideJ1+profilePic), get_node(boardSideJ2+profilePic), get_node(boardSideJ2+profilePicShine))
#		$ChooseActions.countToggleDict.playerTurn = 2
	elif random == "tail":
		$HeadOrTail/ContainerHeadOrTail/Player2Chose.visible = false
		# variable J2dict.turn a modifier pour la logique d'un choix du joueur sur qui commence 
		J1dict.turn = true
		player = 1
		displayPictureShiny(get_node(boardSideJ1+profilePic), get_node(boardSideJ1+profilePicShine), get_node(boardSideJ2+profilePicShine), get_node(boardSideJ2+profilePic))
#		$ChooseActions.countToggleDict.playerTurn = 1
	$TimerTurn.start()
	$TimerSec.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_head_or_tail_timeout():
	$HeadOrTail.visible = false # Replace with function body.



func _on_timer_turn_timeout():
	if J1dict.turn == true: 
		J1dict.turn = false
		J2dict.turn = true
		player = 2
		displayPictureShiny(get_node(boardSideJ1+profilePicShine), get_node(boardSideJ1+profilePic), get_node(boardSideJ2+profilePic), get_node(boardSideJ2+profilePicShine))
		$ChooseActions._on_reset_choice_pressed()
#		$ChooseActions.countToggleDict.playerTurn = 2
#		$ChooseActions/SceneActions/containerActions.visible = true
	elif J2dict.turn == true:
		J2dict.turn = false
		J1dict.turn = true 
		player = 1
		displayPictureShiny(get_node(boardSideJ1+profilePic), get_node(boardSideJ1+profilePicShine), get_node(boardSideJ2+profilePicShine), get_node(boardSideJ2+profilePic))
		$ChooseActions._on_reset_choice_pressed()
#		$ChooseActions.countToggleDict.playerTurn = 1
		$ChooseActions/SceneActions/containerActions.visible = true
		print(J1dict.turn)# Replace with function body.
	$TimerTurn.start()

func _on_button_pressed():
	print(J1dict.turn)
#	print($ChooseActions.player)
	if J1dict.turn == true:
		J1dict.turn = false
		J2dict.turn = true
		player = 2
		displayPictureShiny(get_node(boardSideJ1+profilePicShine), get_node(boardSideJ1+profilePic), get_node(boardSideJ2+profilePic), get_node(boardSideJ2+profilePicShine))
		$ChooseActions._on_reset_choice_pressed()
#		$ChooseActions.countToggleDict.playerTurn = 2
#		$ChooseActions/SceneActions/containerActions.visible = true
		$TimerTurn.start()
		print(J1dict.turn)

func _on_timer_sec_timeout():
	turnSeconds = $TimerTurn.time_left
	$BoardRect/EndTurn/DisplaySeconds.text = str(turnSeconds)

func hideOrShowActions2(countDictKeys):
	var dictForShow = { "attack": "Attack", "drawMalice":"DrawMaliceDeck", "discard":"Discard", "playEventCard":"PlayEventCard", "summon": "Summon"}
	for i in dictForShow.keys():
		if $ChooseActions.countToggleDict[countDictKeys] == 1 and countDictKeys == dictForShow.find_key(dictForShow[i]):
			get_node(boardSideJ2+actionDisplay+dictForShow[i]).visible = true
		elif $ChooseActions.countToggleDict[countDictKeys] == 0 and countDictKeys == dictForShow.find_key(dictForShow[i]):
			get_node(boardSideJ1+actionDisplay+dictForShow[i]).visible = false


func hideOrShowActions1(countDictKeys):
	var dictForShow = { "attack": "Attack", "drawMalice":"DrawMaliceDeck", "discard":"Discard", "playEventCard":"PlayEventCard", "summon": "Summon"}
	for i in dictForShow.keys():
		if $ChooseActions.countToggleDict[countDictKeys] == 1 and countDictKeys == dictForShow.find_key(dictForShow[i]):
			get_node(boardSideJ1+actionDisplay+dictForShow[i]).visible = true
		elif $ChooseActions.countToggleDict[countDictKeys] == 0 and countDictKeys == dictForShow.find_key(dictForShow[i]):
			get_node(boardSideJ1+actionDisplay+dictForShow[i]).visible = false

func controlDisplay():
	var table = ["attack", "drawMalice", "discard", "playEventCard", "summon"]
	if player == 1:
		for i in table:
			hideOrShowActions1(i)
	elif player == 2:
		for i in table:
			hideOrShowActions2(i)

func _on_choose_actions_action_valid():
	controlDisplay()

