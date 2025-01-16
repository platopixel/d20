extends DieState

var die: Die

func enter() -> void:
	if not die.is_note_ready():
		await die.ready

	die.reparent_requested.emit(die)
	die.debugColor.color = Color.WEB_GREEN
	die.debugState.text = "BASE"
	die.pivot_offset = Vector2.ZERO

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		die.pivot_offset = die.get_global_mouse_position() - die.global_position
		transition_requested.emit(self, DieState.State.CLICKED)
