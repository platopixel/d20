class_name Die extends Control

const DIE_FACE = preload("res://scenes/dice/die_face.gd")

signal reparent_requested(which_die: Die)

@export var die: DieModel : set  = _set_die
@export var player_stats: PlayerStats : set = _set_player_stats

@onready var debugColor: ColorRect = $DebugColor
@onready var debugLabel: Label = $DebugLabel
@onready var label: Label = $Label
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var die_state_machine: DieStateMachine = $DieStateMachine as DieStateMachine
@onready var targets: Array[Node] = []
@onready var sprite_2d: TextureRect = $Sprite2D

var original_index := 0 # used to put the die back into the same index of the hand when cancelled
var faces: Array[DIE_FACE] = []
var current_roll: DieFace
var playable := true : set = _set_playable
var disabled := false # dice are set to disabled while another die is being played


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.die_drag_started.connect(_on_die_drag_started)
	Events.die_drag_ended.connect(_on_die_drag_ended)
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
		if not die.is_d20:
			instance.set_texture(i)
		else:
			instance.set_texture(20)

		faces.append(instance)

	label.text = str(die.num_faces)
	sprite_2d.texture = faces[die.num_faces - 1].texture # set default texture to highest die roll
	sprite_2d.material = die.shader
	if sprite_2d.texture:
		var texture_size = sprite_2d.get_size() * sprite_2d.scale
		# Update the Control node's minimum size
		custom_minimum_size = texture_size


func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		sprite_2d.modulate = Color(1, 1, 1, 0.5)
	else:
		sprite_2d.modulate = Color(1, 1, 1, 1)


func _set_player_stats(value: PlayerStats) -> void:
	player_stats = value
	player_stats.stats_changed.connect(_on_player_stats_changed)


func _on_die_drag_started(used_die: Die) -> void:
	if used_die == self:
		return

	disabled = true


func _on_die_drag_ended(_die: Die) -> void:
	disabled = false
	self.playable = player_stats.can_play_die(die)


func _on_player_stats_changed() -> void:
	self.playable = player_stats.can_play_die(die)


func play() -> void:
	if not die:
		return

	roll()
	# die.play(targets, player_stats, current_roll)


func roll() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.5)
	tween.finished.connect(
		func():
			current_roll = faces.pick_random()
			label.text = str(current_roll.number)
			sprite_2d.texture = current_roll.texture
			die.play(targets, player_stats, current_roll)
	)


func set_shader_value(value: float) -> void:
	sprite_2d.material.set_shader_parameter("amount", value)


func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
