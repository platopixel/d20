extends DieModel


func apply_effects(targets: Array[Node], roll) -> void:
	var block_effect := BlockEffect.new()
	block_effect.execute(targets, roll)
