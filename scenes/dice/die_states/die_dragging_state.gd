extends DieState

@export var die: Die

const DRAG_MINIMUM_THRESHOLD := 0.5

var minimum_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		die.reparent(ui_layer)

	die.debugColor.color = Color.NAVY_BLUE
	die.debugLabel.text = "DRAGGING"

	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")

	if mouse_motion:
		die.global_position = die.get_global_mouse_position() - die.pivot_offset

	if cancel:
		print('canceling')
		transition_requested.emit(self, DieState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		print('releasing')
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, DieState.State.RELEASED)
