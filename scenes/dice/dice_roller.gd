class_name DiceRoller extends Node

var dice: Array[Die]
var num_dice_rolled := 0
var all_dice_played := false


func _ready() -> void:
	Events.die_dropped.connect(add_die)
	Events.die_played.connect(_on_die_played)


# Add a die to be rolled later
func add_die(die: Die) -> void:
	dice.append(die)


func roll() -> void:
	all_dice_played = false
	for i in range(dice.size()):
		dice[i].play()


func _on_die_played(die: DieModel) -> void:
	# each die emits a played signal so we maintain a counter to wait for all dice to be played
	num_dice_rolled += 1
	if not all_dice_played and num_dice_rolled >= dice.size():
		all_dice_played = true
		# emit end turn after short delay
		get_tree().create_timer(1.5, false).timeout.connect(
			func():
				Events.player_turn_ended.emit()
				dice.clear()
		)
