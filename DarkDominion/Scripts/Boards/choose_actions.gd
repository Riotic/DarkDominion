extends Node2D

# Initialisation dictionnaire permettant de visualiser les actions choisis du joueurs
var countToggleDict = { "attack": 0, "drawMalice": 0, "summon": 0, "discard": 0, "playEventCard": 0}
# Compteur d'actions choisies
var countActionTaken = 0

signal actionValid
# Var d'actions maximales que la personne peux choisir
var maxAction = 3
# Var indiquant si la personne a choisi le nombre maximum possible d'actions
var noMorePossibleActions = false

# Chemin des nodes de choose_actions
var sceneActionContainer = 'SceneActions/containerActions/'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func buttonPressedResult(button, countDict):
	# Conditions "and" verifiant les countDicts et l'état "toggled" via button_pressed 
	if button == true and noMorePossibleActions == false:
		countToggleDict[countDict] += 1
		countActionTaken = countActionTaken + 1
		verifyValid()
	elif button == false and noMorePossibleActions == false :
		countToggleDict[countDict] -= 1
		countActionTaken = countActionTaken - 1
		verifyValid()

# functions qui réagit à l'état "toggled" du button permettant au joueurs si jamais son choix veut etre changer de recliquer sans passer par le bouton reset
func _on_attack_toggled(button_pressed):
	buttonPressedResult(button_pressed, "attack")

func _on_draw_malice_toggled(button_pressed):
	buttonPressedResult(button_pressed, "drawMalice")

func _on_summon_toggled(button_pressed):
	buttonPressedResult(button_pressed, "summon")

func _on_discard_toggled(button_pressed):
	buttonPressedResult(button_pressed, "discard")

func _on_play_event_card_toggled(button_pressed):
	buttonPressedResult(button_pressed, "playEventCard")

# verification de l'état valid et desactive les bouttons par la meme occasion
func verifyValid():
	if countActionTaken == 3:
		noMorePossibleActions = true
		disableButtons()
		$SceneActions/containerActions/ValidActions.disabled = false
	else: 
		noMorePossibleActions = false
		$SceneActions/containerActions/ValidActions.disabled = true

func checkAndDisable(buttonBox):
	if buttonBox.button_pressed == false:
		buttonBox.disabled = true
	else:
		buttonBox.disabled = false
	
func disableButtons():
# a factorisé ++ , prends les états et les modifies
	var tableActions = ["Attack", "DrawMalice", "Summon", "Discard", "PlayEventCard"]
	for i in tableActions:
		checkAndDisable(get_node(sceneActionContainer+i))


func helpReset(buttonBox):
	buttonBox.button_pressed = false
	buttonBox.disabled = false

# boutton qui reset tout 
func _on_reset_choice_pressed():
	var tableActions = ["Attack", "DrawMalice", "Summon", "Discard", "PlayEventCard"]
	for i in tableActions:
		helpReset(get_node(sceneActionContainer+i))
	countActionTaken = 0
	noMorePossibleActions = false
	$SceneActions/containerActions/ValidActions.disabled = true
	countToggleDict = { "attack": 0, "drawMalice": 0, "summon": 0, "discard": 0, "playEventCard": 0}
	print(countToggleDict)

func hideOrShowActions(countDict, actionsContainer):
	if countDict == 1:
		actionsContainer.visble = true
	else: 
		actionsContainer.visible = false

# les signaux pour interconnectés une scéne à l'autre
func _on_valid_actions_pressed():
	print(countToggleDict)
	emit_signal("actionValid")
	$SceneActions/containerActions.visible = false
	
