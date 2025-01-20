extends Node2D

const DIE_SCENE: PackedScene = preload("res://scenes/dice/die.tscn")

var die: Control
var rolled_number: DieFace

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_roll() -> void:
	die.roll()
