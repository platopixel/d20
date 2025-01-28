class_name EnemyStats extends Stats

enum Relation {HOSTILE, NEUTRAL, ALLY}

@export var ai: PackedScene
@export var name: String
@export_multiline var description: String
@export var relation: Relation
