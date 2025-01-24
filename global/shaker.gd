extends Node


func shake(thing: Node2D, strength: float, duration: float = 0.2) -> void:
	if not thing:
		return

	var original_position := thing.position
	var shake_count := 10
	var tween := create_tween()

	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target := original_position + strength * shake_offset
		if i % 2 == 0:
			target = original_position
		tween.tween_property(thing, "position", target, duration / float(shake_count))
		strength *= 0.75 # taper off the shake strength

	tween.finished.connect(func(): thing.position = original_position)
