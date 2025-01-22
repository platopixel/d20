class_name DieModel extends Resource

enum Type {ATTACK, DEFEND}
enum Target {SELF, ENEMY, EVERYONE}

@export_group("Die Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int
@export var num_faces: int

@export_group("Die Visuals")
@export var shader: ShaderMaterial
@export_multiline var tooltip_text: String
@export var icon: Texture


func is_enemy_targeted() -> bool:
	return target == Target.ENEMY


func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
	# hack to get access to scene tree in resource
	var tree := targets[0].get_tree()

	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ENEMY:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []


func play(targets: Array[Node], player_stats: PlayerStats, roll) -> void:
	Events.die_played.emit(self)
	player_stats.energy -= cost

	apply_effects(_get_targets(targets), roll)


func apply_effects(_targets: Array[Node], roll) -> void:
	pass
