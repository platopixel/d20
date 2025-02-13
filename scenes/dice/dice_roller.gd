class_name DiceRoller extends Node

var dice: Array[Die]
var num_dice_rolled := 0

func _ready() -> void:
	Events.die_dropped.connect(add_die)
	Events.die_played.connect(_on_die_played)


func add_die(die: Die) -> void:
	dice.append(die)


func roll() -> void:
	for i in range(dice.size()):
		dice[i].play()


func _on_die_played(die: DieModel) -> void:
	var all_dice_played := false
	num_dice_rolled += 1
	if not all_dice_played and num_dice_rolled >= dice.size():
		all_dice_played = true
		# emit end turn after short delay
		get_tree().create_timer(2.0, false).timeout.connect(
			func():
				Events.player_turn_ended.emit()
				dice.clear()
		)
