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


func is_enemy_targeted() -> bool:
	return target == Target.ENEMY
