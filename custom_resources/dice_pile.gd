class_name DicePile extends Resource

signal dice_pile_size_changed(dice_amount)

@export var dice: Array[DieModel] = []

func empty() -> bool:
	return dice.is_empty()


func draw_die() -> Die:
	var die = dice.pop_front()
	dice_pile_size_changed.emit(dice.size())
	return die


func add_die(die: DieModel) -> void:
	dice.append(die)
	dice_pile_size_changed.emit(dice.size())


func shuffle() -> void:
	dice.shuffle()


func clear() -> void:
	dice.clear()
	dice_pile_size_changed.emit(dice.size())


func _to_string() -> String:
	var _dice_strings: PackedStringArray = []
	for i in range(dice.size()):
		_dice_strings.append("%s: %s" % [i+1, dice[i].id])
	return "\n".join(_dice_strings)
