extends DieState

@export var die: Die

var played: bool

func enter() -> void:
	die.debugColor.color = Color.DARK_VIOLET
	die.debugLabel.text = "RELEASED"

	played = false

	# check if die is released in the play area
	if not die.targets.is_empty():
		Events.die_dropped.emit(die)
		# die.play()
		played = true
		# Events.tooltip_hide_requested.emit()


func on_input(_event: InputEvent) -> void:
	if played:
		return

	transition_requested.emit(self, DieState.State.BASE)
