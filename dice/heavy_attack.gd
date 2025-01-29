extends DieModel


func apply_effects(targets: Array[Node], roll) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.execute(targets, roll)
