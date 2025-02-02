class_name DieFace extends Node

@export var number: int : set = set_number

var texture: Texture2D
var points: int = 0
var effects: Array # array of effect nodes
var DIE_TEXTURES := {
	1: load("res://assets/d6-1.png"),
	2: load("res://assets/d6-2.png"),
	3: load("res://assets/d6-3.png"),
	4: load("res://assets/d6-4.png"),
	5: load("res://assets/d6-5.png"),
	6: load("res://assets/d6-6.png"),
	20: load("res://assets/d20-blank.png")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_number(value: int) -> void:
	number = value


func set_texture(value: int) -> void:
	texture = DIE_TEXTURES[value]
