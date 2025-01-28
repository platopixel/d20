class_name EnemyTooltip extends Tooltip


func _ready() -> void:
	Events.enemy_tooltip_requested.connect(_on_enemy_tooltip_requested)
	super()


func _get_intent_text(type: Intent.Type) -> String:
	if type == Intent.Type.ATTACK:
		return "Physical attack"
	elif type == Intent.Type.DEFEND:
		return "Physical block"
	else:
		return "UNKNOWN"

func _on_enemy_tooltip_requested(stats: EnemyStats, intent: Intent = null) -> void:
	var name = stats.name
	var description = stats.description
	var relation = str(EnemyStats.Relation.keys()[stats.relation])
	var hp_text = "%s/%s" % [stats.hp, stats.max_hp]
	var intent_text: String
	if not intent:
		intent_text = "UNKNOWN"
	else:
		intent_text = _get_intent_text(intent.type)
	var tooltip_text = "Name: %s\n\nInfo: %s\n\nRelation: %s\n\nIntent: %s\n\nCondition: %s" % [name, description, relation, intent_text, hp_text]
	show_tooltip(tooltip_text)
