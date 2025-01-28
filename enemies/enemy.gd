class_name Enemy extends Node2D

@export var stats: EnemyStats : set = set_enemy_stats

@onready var stats_ui: StatsUI = $StatsUI as StatsUI
@onready var intent_ui: IntentUI = $IntentUI as IntentUI

var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction : set = set_current_action


func set_current_action(value: EnemyAction) -> void:
	current_action = value
	if current_action:
		intent_ui.update_intent(current_action.intent)
		Events.enemy_tooltip_requested.emit.call_deferred(stats, current_action.intent)


func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()

	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)

	update_enemy()


func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()

	var new_action_picker: EnemyActionPicker = stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.enemy = self


func update_action() -> void:
	if not enemy_action_picker:
		return

	if not current_action:
		current_action = enemy_action_picker.get_action()
		return

	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action


func update_stats() -> void:
	stats_ui.update_stats(stats)
	Events.enemy_tooltip_requested.emit.call_deferred(stats)


func update_enemy() -> void:
	if not stats is Stats:
		return

	if not is_inside_tree():
		await ready

	setup_ai()
	update_stats()


func do_turn() -> void:
	stats.block = 0

	if not current_action:
		return

	current_action.perform_action()


func take_damage(damage: int) -> void:
	if stats.hp <= 0:
		return

	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.2)

	tween.finished.connect(
		func():
			if stats.hp <= 0:
				queue_free()
	)
