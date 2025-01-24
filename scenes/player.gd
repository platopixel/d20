class_name Player extends Node2D

@export var stats: PlayerStats : set = set_player_stats

@onready var stats_ui: StatsUI = $StatsUI as StatsUI


func set_player_stats(value: PlayerStats) -> void:
	stats = value

	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)

	update_player()


func update_player() -> void:
	if not stats is PlayerStats:
		return

	if not is_inside_tree():
		await ready

	update_stats()


func update_stats() -> void:
	stats_ui.update_stats(stats)


func take_damage(damage: int) -> void:
	if stats.hp <= 0:
		return

	stats.take_damage(damage)

	if stats.hp <= 0:
		Events.player_died.emit()
		queue_free()
