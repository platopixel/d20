extends Sprite2D

@onready var floating_sprite: Sprite2D = $"."
@onready var default_pos = floating_sprite.get_global_position()

var frequency := 3.0
var amplitude := 3.0
var time := 0.0


func _process(delta: float) -> void:
	time += delta * frequency

	floating_sprite.set_global_position(default_pos + Vector2(0, sin(time) * amplitude))
