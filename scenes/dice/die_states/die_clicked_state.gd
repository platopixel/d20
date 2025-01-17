extends DieState

@export var die: Die

func enter() -> void:
	die.debugColor.color = Color.ORANGE
	die.debugLabel.text = "CLICKED"
	die.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		transition_requested.emit(self, DieState.State.DRAGGING)
