class_name EnergyUI extends Panel

@export var player_stats: PlayerStats : set = _set_player_stats

@onready var energy_label: Label = $EnergyLabel


func _ready() -> void:
	player_stats.energy = 3


func _set_player_stats(value: PlayerStats) -> void:
	player_stats = value
	print('energy ui:', player_stats.energy)

	if not player_stats.stats_changed.is_connected(_on_stats_changed):
		player_stats.stats_changed.connect(_on_stats_changed)

	if not is_node_ready():
		await ready

	_on_stats_changed()


func _on_stats_changed() -> void:
	print('energy ui stats changed: ', player_stats.energy)
	energy_label.text = "%s/%s" % [player_stats.energy, player_stats.max_energy]
