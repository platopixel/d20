extends DieState

var die: Die

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		die.reparent(ui_layer)

	die.debugColor.color = Color.NAVY_BLUE
	die.debugLabel.text = "DRAGGING"

# https://youtu.be/Pa0P1lUoC-M?list=PL6SABXRSlpH8CD71L7zye311cp9R4JazJ&t=1737
