extends Node2D

@export var player_stats: PlayerStats # top-level stats entry-point for battles

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player: Player = $Player


func _ready() -> void:
	# Normally we do this in a 'run' function to maintain player stats between battles
	var new_stats: PlayerStats = player_stats.create_instance()
	battle_ui.player_stats = new_stats
	player.stats = new_stats

	start_battle(new_stats)

	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(player_handler.start_turn) # todo: add enemy turn here


func start_battle(stats: PlayerStats) -> void:
	player_handler.start_battle(stats)
