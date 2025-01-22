class_name Stats extends Resource

signal stats_changed

@export var max_hp := 999
@export var art: Texture

var hp: int : set = set_hp
var block: int : set = set_block


func set_hp(value: int) -> void:
	hp = clampi(value, 0, max_hp)
	stats_changed.emit()


func set_block(value: int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()


func take_damage(damage: int) -> void:
	if damage <= 0:
		return

	var initial_damage = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initial_damage, 0, block)
	self.hp -= damage


func heal(amount: int) -> void:
	self.hp += amount


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.hp = max_hp
	instance.block = 0
	return instance
