extends DieState

@export var die: Die

var played: bool

func enter() -> void:
	die.debugColor.color = Color.DARK_VIOLET
	die.debugLabel.text = "RELEASED"

	played = false

	if not die.targets.is_empty():
		die.roll()
		played = true
		print("play die for target(s) ", die.targets)


func on_input(_event: InputEvent) -> void:
	if played:
		return

	transition_requested.emit(self, DieState.State.BASE)
