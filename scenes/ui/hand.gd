class_name Hand extends HBoxContainer

var dice_played_this_turn := 0


func _ready() -> void:
	Events.die_played.connect(_on_die_played)

	for child in get_children():
		var die := child as Die
		die.reparent_requested.connect(_on_die_ui_reparent_requested)


func _on_die_played(_die: DieModel) -> void:
	dice_played_this_turn += 1


func _on_die_ui_reparent_requested(child: Die) -> void:
	child.reparent(self)
	var new_index := clampi(child.original_index - dice_played_this_turn, 0, get_child_count())
	move_child.call_deferred(child, new_index)
