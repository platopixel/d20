class_name Hand extends HBoxContainer


func _ready() -> void:
	for child in get_children():
		var die := child as Die
		die.reparent_requested.connect(_on_die_ui_reparent_requested)


func _on_die_ui_reparent_requested(child: Die) -> void:
	child.reparent(self)
