extends DieState

var die: Die

func enter() -> void:
	die.debugColor.color = Color.ORANGE
	die.debugState.text = "CLICKED"
	die.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		transition_requested.emit(self, DieState.State.DRAGGING)
