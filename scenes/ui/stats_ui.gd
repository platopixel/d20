class_name StatsUI extends HBoxContainer

@onready var block: HBoxContainer = $Block
@onready var block_label: Label = %BlockLabel
@onready var hp: HBoxContainer = $HP
@onready var hp_label: Label = %HPLabel


func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	hp_label.text = str(stats.hp)

	block.visible = stats.block > 0
	hp.visible = stats.hp > 0
