class_name HealthUI extends Panel

@export var player_stats: PlayerStats : set = _set_player_stats

@onready var hp_label: Label = $HPLabel


func _ready() -> void:
	# player_stats.energy = 3
	pass


func _set_player_stats(value: PlayerStats) -> void:
	player_stats = value

	if not player_stats.stats_changed.is_connected(_on_stats_changed):
		player_stats.stats_changed.connect(_on_stats_changed)

	if not is_node_ready():
		await ready

	_on_stats_changed()


func _on_stats_changed() -> void:
	hp_label.text = "%s/%s" % [player_stats.hp, player_stats.max_hp]
