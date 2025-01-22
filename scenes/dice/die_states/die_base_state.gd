extends DieState

@export var die: Die

func enter() -> void:
	die.reparent_requested.emit(die)
	die.debugColor.color = Color.WEB_GREEN
	die.debugLabel.text = "BASE"
	die.pivot_offset = Vector2.ZERO
	Events.tooltip_hide_requested.emit()


func on_gui_input(event: InputEvent) -> void:
	if not die.playable or die.disabled:
		return

	if event.is_action_pressed("left_mouse"):
		die.pivot_offset = die.get_global_mouse_position() - die.global_position
		transition_requested.emit(self, DieState.State.CLICKED)


func on_mouse_entered() -> void:
	if not die.playable or die.disabled:
		return
	# todo: add visual indicator that the die is being hovered
	Events.die_tooltip_requested.emit(die.die.icon, die.die.tooltip_text)


func on_mouse_exited() -> void:
	if not die.playable or die.disabled:
		return
	# todo: remove visual indicator that the die is being hovered
	Events.tooltip_hide_requested.emit()
