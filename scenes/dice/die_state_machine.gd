class_name DieStatMachine extends Node

@export var initial_state: DieState

var current_state: DieState
var states := {}

func init(die: Die) -> void:
	for child in get_children():
		if child is DieState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.die = die

	if initial_state:
		initial_state.enter()
		current_state = initial_state

func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_mouse_exited(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func _on_transition_requested(from: DieState, to: DieState.State) -> void:
	if from != current_state:
		return

	var new_state: DieState = states[to]
	if not new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
