extends Node2D

const DIE_SCENE: PackedScene = preload("res://scenes/dice/die.tscn")

var die: Node2D
var rolled_number: Die_Face

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	die = DIE_SCENE.instantiate()
	die.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	add_child(die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_roll() -> void:
	die.roll()
