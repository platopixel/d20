class_name Die extends Node2D

const DIE_FACE = preload("res://scenes/dice/die_face.gd")

signal reparent_requested(which_die: Die)

@onready var debugColor: ColorRect = $DebugColor
@onready var debugLabel: Label = $DebugLabel

var faces: Array[DIE_FACE] = []
var current_roll: Die_Face

func _init() -> void:
	for i in range(1, 21):
		var instance = DIE_FACE.new()
		instance.number = i
		faces.append(instance)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func roll() -> void:
	current_roll = faces.pick_random()
	$Label.text = str(current_roll.number)
