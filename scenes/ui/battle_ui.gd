class_name BattleUI extends CanvasLayer

@export var player_stats: PlayerStats : set = _set_player_stats

@onready var hand: Hand = $Hand as Hand
@onready var energy_ui: EnergyUI = $EnergyUI as EnergyUI
@onready var end_turn_button: TextureButton = %EndTurnButton


func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)


func _set_player_stats(value: PlayerStats) -> void:
	player_stats = value
	energy_ui.player_stats = player_stats
	hand.player_stats = player_stats


func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false


func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
