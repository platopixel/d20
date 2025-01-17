class_name Die extends Control

const DIE_FACE = preload("res://scenes/dice/die_face.gd")

signal reparent_requested(which_die: Die)

@onready var debugColor: ColorRect = $DebugColor
@onready var debugLabel: Label = $DebugLabel
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var die_state_machine: DieStatMachine = $DieStateMachine as DieStatMachine
@onready var targets: Array[Node] = []

var faces: Array[DIE_FACE] = []
var current_roll: Die_Face

func init() -> void:
	for i in range(1, 21):
		var instance = DIE_FACE.new()
		instance.number = i
		faces.append(instance)

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

func roll() -> void:
	current_roll = faces.pick_random()
	$Label.text = str(current_roll.number)


func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
