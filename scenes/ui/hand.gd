class_name Hand extends HBoxContainer

@export var player_stats: PlayerStats

@onready var die_scene := preload("res://scenes/dice/die.tscn")


func add_die(die: DieModel) -> void:
	var die_ui := die_scene.instantiate()
	add_child(die_ui)
	die_ui.reparent_requested.connect(_on_die_ui_reparent_requested)
	die_ui.die = die
	die_ui.player_stats = player_stats


func discard_die(die: Die) -> void:
	die.queue_free()


func disable_hand() -> void:
	for die in get_children():
		die.disabled = true


func _on_die_ui_reparent_requested(child: Die) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
