extends EnemyAction

@export var damage := 12


func is_performable() -> bool:
	return true


func perform_action() -> void:
	if not enemy or not target:
		return

	var tween := create_tween().set_trans(Tween.TRANS_QUAD)
	var start := enemy.global_position
	var end := (target.global_position + Vector2.RIGHT * 32) / 2
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage

	tween.tween_property(enemy, "global_position", end, 0.1)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.08)
	tween.tween_property(enemy, "global_position", start, 0.1)

	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
