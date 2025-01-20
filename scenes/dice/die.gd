class_name Die extends Control

const DIE_FACE = preload("res://scenes/dice/die_face.gd")

signal reparent_requested(which_die: Die)

@export var die: DieModel : set  = _set_die

@onready var debugColor: ColorRect = $DebugColor
@onready var debugLabel: Label = $DebugLabel
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var die_state_machine: DieStateMachine = $DieStateMachine as DieStateMachine
@onready var targets: Array[Node] = []
@onready var sprite_2d: Sprite2D = $Sprite2D

var faces: Array[DIE_FACE] = []
var current_roll: DieFace


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	die_state_machine.init(self)


func _input(event: InputEvent) -> void:
	die_state_machine.on_input(event)


func _on_gui_input(event: InputEvent) -> void:
	die_state_machine.on_gui_input(event)


func _on_mouse_entered() -> void:
	die_state_machine.on_mouse_entered()


func _on_mouse_exited() -> void:
	die_state_machine.on_mouse_exited()


func _set_die(value: DieModel) -> void:
	if not is_node_ready():
		await ready

	die = value
	for i in range(1, die.num_faces + 1):
		var instance = DIE_FACE.new()
		instance.number = i
		faces.append(instance)

	sprite_2d.material = die.shader


func roll() -> void:
	current_roll = faces.pick_random()
	$Label.text = str(current_roll.number)


func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
