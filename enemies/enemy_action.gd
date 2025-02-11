class_name EnemyAction extends Node

enum ActionType {CONDITIONAL, CHANCE_BASED}

@export var intent: Intent
@export var action_type: ActionType
@export_range(0.0, 10.0) var chance_weight := 0.0

@onready var accumulated_weight := 0.0

var enemy: Enemy
var target: Node2D


func is_performable() -> bool:
	return false


func perform_action() -> void:
	pass
